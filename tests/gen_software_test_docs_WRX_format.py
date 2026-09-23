"""
gen_unit_test_docs.py

Scans the Unity test suite source files, then:
  1. Generates 205-VID-019 Software Test Specification.docx  (unfilled checklist)
  2. Runs the test executables
  3. Generates 205-VID-019 Software Test Report YYYY-MM-DD.docx  (PASS/FAIL results)

Run from any directory:
    python "Documentation/Test_Specification/gen_unit_test_docs.py"
"""

import re
import subprocess
from datetime import date, datetime
from pathlib import Path

from docx import Document
from docx.shared import Pt, Inches, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

# ── Paths ──────────────────────────────────────────────────────────────────
SCRIPT_DIR = Path(__file__).parent.resolve()

# This script originally assumed it lived in:
#   Documentation/Test_Specification/gen_unit_test_docs.py
# If you put it directly in the tests/ folder, the original path math looks
# in the wrong place.  This version supports either location.
if SCRIPT_DIR.name.lower() == 'tests':
    TESTS_DIR = SCRIPT_DIR
    PROJECT_ROOT = SCRIPT_DIR.parent
    DOC_ROOT = PROJECT_ROOT / 'Documentation'
else:
    DOC_ROOT = SCRIPT_DIR.parent                          # Documentation/
    PROJECT_ROOT = DOC_ROOT.parent
    TESTS_DIR = PROJECT_ROOT / 'tests'

# Put both generated Word documents directly in Documentation/.
SPEC_DIR = DOC_ROOT
REPORT_DIR = DOC_ROOT

# ── Document identity ──────────────────────────────────────────────────────
# Change these values if the WRX document number, name, or software revision
# changes later.  The title block and output filenames use these constants.
DOCUMENT_NUMBER = '205-VID-019'
PRODUCT_NAME = 'HD Zoom and Focus Inspection Camera'
SOFTWARE_REVISION = '1.02'
TESTER_INITIALS = 'EBB'

# ── Suite discovery ────────────────────────────────────────────────────────
# No file-specific suite table.  The script discovers every Unity test source
# in TESTS_DIR matching test_*.c, then infers:
#   file    -> actual .c filename
#   exe     -> same basename with .exe
#   prefix  -> first TC-XX-NN found in that source file; fallback from filename
#   display -> optional suite metadata in source comments; fallback from filename

AUTO_DISCOVER_TESTS = True


def _name_body_from_file(file_name: str) -> str:
    """test_menu_var.c -> menu_var"""
    stem = Path(file_name).stem
    return stem[5:] if stem.startswith('test_') else stem


def _display_from_name(name_body: str) -> str:
    """
    Generic filename humanizer.
      menu_var    -> Menu Var
      bldmessages -> Bldmessages
      mdin        -> Mdin

    If you need a prettier display name with ZERO Python changes, add a source
    comment such as:
        * Test Suite: Titler Logic
    or:
        * Suite: Titler Logic
    """
    words = [w for w in re.split(r'[_\W]+', name_body) if w]
    return ' '.join(w[:1].upper() + w[1:] for w in words) if words else 'Unit Tests'


def _display_from_content(content: str, file_name: str) -> str:
    """
    Prefer generic metadata embedded in the C file. This keeps the Python free
    of file-specific overrides while still letting each test file name itself.
    Supported examples:
        * Test Suite: EEPROM Emulation
        * Suite: Titler Logic
        // Test Suite: MDIN Presets
    """
    m = re.search(r'^[ \t]*(?://|/\*|\*)[ \t]*(?:Test[ \t]+Suite|Suite)[ \t]*:[ \t]*(.+?)\s*$',
                  content, flags=re.MULTILINE | re.IGNORECASE)
    if m:
        return m.group(1).strip().rstrip('*/').strip()

    # Best-effort extraction from common file headers like:
    #   Unity unit tests for the EEPROM emulation layer (...)
    m = re.search(r'Unity\s+unit\s+tests\s+for\s+(?:the\s+)?(.+?)(?:\.|\n)',
                  content, flags=re.IGNORECASE | re.DOTALL)
    if m:
        text = ' '.join(m.group(1).split())
        text = re.sub(r'\s*\([^)]*\)', '', text).strip()
        text = re.sub(r'\s+in\s+.*$', '', text, flags=re.IGNORECASE).strip()
        text = re.sub(r'\s+(layer|logic|functions?)$', '', text, flags=re.IGNORECASE).strip()
        if text:
            return text[:1].upper() + text[1:]

    return _display_from_name(_name_body_from_file(file_name))


def _prefix_from_name(name_body: str) -> str:
    """
    Fallback only. Prefer TC IDs already present in the source file.
      menu_var -> TC-MV
      eeprom   -> TC-E
    """
    parts = [p for p in re.split(r'[_\W]+', name_body) if p]
    if len(parts) >= 2:
        initials = ''.join(p[0].upper() for p in parts)
    elif parts:
        initials = parts[0][:4].upper()
    else:
        initials = 'UT'
    return f'TC-{initials}'


def _prefix_from_content(content: str, file_name: str) -> str:
    """
    Find the first TC prefix used anywhere in the source.
      TC-TT-01 -> TC-TT
      TC-MV-13 -> TC-MV
    This fixes the titler case without hardcoding test_titler.c.
    """
    m = re.search(r'\b(TC-[A-Z]+)-\d+\b', content)
    if m:
        return m.group(1)

    return _prefix_from_name(_name_body_from_file(file_name))


def discover_suites() -> list[dict]:
    suites = []

    for path in sorted(TESTS_DIR.glob('test_*.c')):
        content = path.read_text(encoding='utf-8', errors='replace')

        # Only document real Unity test files.
        if 'RUN_TEST(' not in content:
            continue

        suites.append({
            'file':    path.name,
            'exe':     path.with_suffix('.exe').name,
            'display': _display_from_content(content, path.name),
            'prefix':  _prefix_from_content(content, path.name),
        })

    return suites


# Keep the old variable name so the rest of the original script can stay simple.
SUITES = discover_suites() if AUTO_DISCOVER_TESTS else []

# ── Style constants ────────────────────────────────────────────────────────
DARK_BLUE  = (26,  58,  92)
LIGHT_BLUE = 'E8F0FE'
HDR_BG     = '1A3A5C'
GREEN      = (0,  128,   0)
RED        = (192,  0,   0)
GREY       = (128, 128, 128)
CHECKBOX   = '☐'


# ── Low-level helpers ──────────────────────────────────────────────────────

def set_font(run, name='Calibri', size=11, bold=False, italic=False, color=None):
    run.font.name   = name
    run.font.size   = Pt(size)
    run.font.bold   = bold
    run.font.italic = italic
    if color:
        run.font.color.rgb = RGBColor(*color)


def set_cell_shading(cell, hex_color: str):
    tcPr = cell._tc.get_or_add_tcPr()
    shd  = OxmlElement('w:shd')
    shd.set(qn('w:val'),   'clear')
    shd.set(qn('w:color'), 'auto')
    shd.set(qn('w:fill'),  hex_color)
    tcPr.append(shd)


def remove_table_borders(table):
    for row in table.rows:
        for cell in row.cells:
            tcPr  = cell._tc.get_or_add_tcPr()
            tcBdr = OxmlElement('w:tcBorders')
            for side in ('top', 'left', 'bottom', 'right', 'insideH', 'insideV'):
                el = OxmlElement(f'w:{side}')
                el.set(qn('w:val'), 'none')
                tcBdr.append(el)
            tcPr.append(tcBdr)


def humanize(func_name: str) -> str:
    """'test_init_formats_blank_flash' → 'Init formats blank flash'"""
    name = re.sub(r'^test_', '', func_name)
    words = name.replace('_', ' ')
    return words[0].upper() + words[1:] if words else words


# ── Step 1: Parse test source files ───────────────────────────────────────

def _parse_tc_descriptions(content: str) -> dict[str, str]:
    """
    Finds per-test comment blocks:
        /* ====...
         * TC-XX-NN
         * First description line here
    Returns {tc_id: description_text}.
    """
    pattern = re.compile(
        r'/\*\s*=+\s*\n'                      # /* ===... line
        r'\s*\*\s*(TC-[A-Z]+-\d+)\s*\n'       #  * TC-XX-NN
        r'\s*\*\s*([^\n*]+)'                   #  * Description
    )
    return {
        m.group(1).strip(): m.group(2).strip().rstrip(':')
        for m in pattern.finditer(content)
    }


def extract_tests(suite: dict) -> list[tuple[str, str, str]]:
    """
    Returns [(tc_id, func_name, description), …] for every test in the suite.
    TC-ID and func_name are read from the file header comment mapping block.
    Description is pulled from the per-test block comment.
    Falls back to RUN_TEST() call order when the header block is absent.
    """
    content  = (TESTS_DIR / suite['file']).read_text(encoding='utf-8')
    desc_map = _parse_tc_descriptions(content)

    header_re = re.compile(
        rf'({re.escape(suite["prefix"])}-\d+)\s+(test_\w+)'
    )
    pairs = header_re.findall(content)

    if not pairs:
        run_tests = re.findall(r'RUN_TEST\((\w+)\)', content)
        pairs = [(f'{suite["prefix"]}-{i+1:02d}', name)
                 for i, name in enumerate(run_tests)]

    return [(tc_id, func_name, desc_map.get(tc_id, ''))
            for tc_id, func_name in pairs]


# ── Step 2: Run tests, parse Unity output ─────────────────────────────────

def run_suite(suite: dict) -> dict[str, str]:
    """
    Executes the test binary and parses Unity's stdout.
    Unity line format:  filename.c:line:func_name:PASS
                        filename.c:line:func_name:FAIL:message
    Returns {func_name: 'PASS'|'FAIL'}.
    """
    exe     = TESTS_DIR / suite['exe']
    results: dict[str, str] = {}

    try:
        proc = subprocess.run(
            [str(exe)],
            capture_output=True, text=True,
            cwd=str(TESTS_DIR), timeout=30,
        )
        output = proc.stdout + proc.stderr
    except (FileNotFoundError, subprocess.TimeoutExpired) as exc:
        print(f'  [!] {suite["exe"]}: {exc}')
        return results

    for line in output.splitlines():
        m = re.match(r'^[^:]+:\d+:(\w+):(PASS|FAIL)', line)
        if m:
            results[m.group(1)] = m.group(2)

    return results


# ── Step 3: Shared document components ────────────────────────────────────

def _set_paragraph_spacing(paragraph, before=0, after=0):
    paragraph.paragraph_format.space_before = Pt(before)
    paragraph.paragraph_format.space_after = Pt(after)


def _add_centered_line(doc: Document, text: str, size=11, bold=False, color=None, after=0):
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    _set_paragraph_spacing(p, before=0, after=after)
    r = p.add_run(text)
    set_font(r, size=size, bold=bold, color=color)
    return p


def _add_title_block(doc: Document, document_type: str):
    """
    Adds the simple WRX title style shown in the reference document:
        205-VID-019 HD Wireless Receiver
        Software Test Specification / Software Test Report
        Software Revision: 2.00
    """
    for section in doc.sections:
        section.top_margin    = Inches(1)
        section.bottom_margin = Inches(1)
        section.left_margin   = Inches(1)
        section.right_margin  = Inches(1)

    _add_centered_line(
        doc,
        f'{DOCUMENT_NUMBER} {PRODUCT_NAME}',
        size=16,
        bold=True,
        color=DARK_BLUE,
        after=4,
    )
    _add_centered_line(
        doc,
        f'Software {document_type}',
        size=13,
        bold=False,
        color=DARK_BLUE,
        after=4,
    )
    _add_centered_line(
        doc,
        f'Software Revision: {SOFTWARE_REVISION}',
        size=11,
        bold=False,
        color=None,
        after=10,
    )


def _format_plain_table(table, font_size=10):
    remove_table_borders(table)
    for row in table.rows:
        for cell in row.cells:
            for para in cell.paragraphs:
                _set_paragraph_spacing(para, before=0, after=0)
                for run in para.runs:
                    run.font.name = 'Calibri'
                    run.font.size = Pt(font_size)


def _add_initials_date_table(doc: Document, initials: str = '', signed_date: str = ''):
    """
    Adds the two-column initials/date signoff table used at the bottom of the
    WRX example document.  The first row holds the filled-in values, and the
    second row labels the columns.
    """
    table = doc.add_table(rows=2, cols=2)
    table.autofit = False
    table.columns[0].width = Inches(4.9)
    table.columns[1].width = Inches(1.5)

    table.cell(0, 0).text = initials
    table.cell(0, 1).text = signed_date
    table.cell(1, 0).text = 'Initials'
    table.cell(1, 1).text = 'Date'

    for row in table.rows:
        row.cells[0].width = Inches(4.9)
        row.cells[1].width = Inches(1.5)
        for i, cell in enumerate(row.cells):
            for para in cell.paragraphs:
                para.alignment = WD_ALIGN_PARAGRAPH.CENTER if i == 1 else WD_ALIGN_PARAGRAPH.LEFT

    _format_plain_table(table, font_size=10)
    return table
def _create_results_table(doc: Document):
    """4-column table: indicator | test | result | notes."""
    tbl  = doc.add_table(rows=1, cols=4)
    tbl.style = 'Table Grid'

    widths  = [Inches(0.35), Inches(4.05), Inches(0.75), Inches(1.35)]
    headers = [CHECKBOX, 'Test', 'Result', 'Notes']

    for i, (cell, txt) in enumerate(zip(tbl.rows[0].cells, headers)):
        cell.width = widths[i]
        para = cell.paragraphs[0]
        para.alignment = (WD_ALIGN_PARAGRAPH.CENTER if i != 1
                          else WD_ALIGN_PARAGRAPH.LEFT)
        r = para.add_run(txt)
        set_font(r, size=10, bold=True, color=(255, 255, 255))
        set_cell_shading(cell, HDR_BG)

    return tbl


def _add_section_row(tbl, suite: dict):
    row  = tbl.add_row()
    cell = row.cells[0]
    cell.merge(row.cells[3])
    r = cell.paragraphs[0].add_run(f'{suite["prefix"]} — {suite["display"]}')
    set_font(r, size=10, bold=True, color=DARK_BLUE)
    set_cell_shading(cell, LIGHT_BLUE)


def _fill_name_cell(cell, tc_id: str, func_name: str, description: str):
    """Bold TC ID + name on line 1; small italic description on line 2."""
    para = cell.paragraphs[0]
    r = para.add_run(f'{tc_id}: {humanize(func_name)}')
    set_font(r, size=10, bold=True)
    if description:
        p = cell.add_paragraph()
        r = p.add_run(description)
        set_font(r, size=9, italic=True, color=GREY)


# ── Step 4: Build Software Test Specification (unfilled) ────────────────────────────

def build_spec(suites_tests: list) -> Path:
    doc = Document()
    _add_title_block(doc, 'Test Specification')
    tbl = _create_results_table(doc)

    for suite, tests in suites_tests:
        _add_section_row(tbl, suite)
        for tc_id, func_name, description in tests:
            row   = tbl.add_row()
            cells = row.cells

            cb = cells[0].paragraphs[0]
            cb.alignment = WD_ALIGN_PARAGRAPH.CENTER
            r = cb.add_run(CHECKBOX)
            r.font.name = 'Segoe UI Symbol'
            r.font.size = Pt(12)

            _fill_name_cell(cells[1], tc_id, func_name, description)

            res = cells[2].paragraphs[0]
            res.alignment = WD_ALIGN_PARAGRAPH.CENTER
            r = res.add_run('☐ Pass\n☐ Fail\n☐ Skip')
            r.font.name = 'Segoe UI Symbol'
            r.font.size = Pt(9)

            cells[3].paragraphs[0].add_run('')

    doc.add_paragraph()
    _add_initials_date_table(doc, initials='', signed_date='')

    SPEC_DIR.mkdir(parents=True, exist_ok=True)
    out = SPEC_DIR / f'{DOCUMENT_NUMBER} Software Test Specification.docx'
    doc.save(str(out))
    return out


# ── Step 5: Build Software Test Report (filled with PASS/FAIL) ─────────────────────

def build_report(suites_tests: list, all_results: list) -> tuple[int, int, int, Path]:
    doc = Document()
    _add_title_block(doc, 'Test Report')
    tbl = _create_results_table(doc)

    total = passed = failed = 0

    sym_map = {'PASS': '✔', 'FAIL': '✘'}
    col_map = {'PASS': GREEN, 'FAIL': RED}

    for (suite, tests), results in zip(suites_tests, all_results):
        _add_section_row(tbl, suite)
        for tc_id, func_name, description in tests:
            verdict = results.get(func_name, 'NOT RUN')
            row     = tbl.add_row()
            cells   = row.cells

            cb = cells[0].paragraphs[0]
            cb.alignment = WD_ALIGN_PARAGRAPH.CENTER
            r = cb.add_run(sym_map.get(verdict, '?'))
            r.font.name = 'Segoe UI Symbol'
            r.font.size = Pt(12)
            r.font.color.rgb = RGBColor(*col_map.get(verdict, GREY))

            _fill_name_cell(cells[1], tc_id, func_name, description)

            res = cells[2].paragraphs[0]
            res.alignment = WD_ALIGN_PARAGRAPH.CENTER
            r = res.add_run(verdict)
            set_font(r, size=10, bold=(verdict in ('PASS', 'FAIL')),
                     color=col_map.get(verdict, GREY))

            cells[3].paragraphs[0].add_run('')

            total += 1
            if verdict == 'PASS':
                passed += 1
            elif verdict == 'FAIL':
                failed += 1

    overall       = 'PASS' if (failed == 0 and passed == total and total > 0) else 'FAIL'
    overall_color = GREEN if overall == 'PASS' else RED
    final_color = GREY

    doc.add_paragraph()
    p = doc.add_paragraph()
    r = p.add_run(f'Summary: {passed}/{total} passed — {failed} failed')
    set_font(r, size=12, bold=True, color=overall_color)

    doc.add_paragraph()
    _add_initials_date_table(doc, initials=TESTER_INITIALS, signed_date=f'{date.today().month}/{date.today().day}/{date.today().year}')

    REPORT_DIR.mkdir(parents=True, exist_ok=True)
    out = REPORT_DIR / f'{DOCUMENT_NUMBER} Software Test Report {datetime.now().strftime("%Y-%m-%d %H%M")}.docx'
    doc.save(str(out))
    return passed, failed, total, out


# ── Main ───────────────────────────────────────────────────────────────────

def main():
    print('Scanning test files …')
    suites_tests = []
    for suite in SUITES:
        tests = extract_tests(suite)
        print(f'  {suite["file"]}: {len(tests)} tests')
        suites_tests.append((suite, tests))

    print()
    spec_path = build_spec(suites_tests)
    print(f'Spec saved:   {spec_path}')

    print('\nRunning tests …')
    all_results = []
    for suite, _ in suites_tests:
        print(f'  {suite["exe"]} … ', end='', flush=True)
        results = run_suite(suite)
        all_results.append(results)
        n_pass = sum(1 for v in results.values() if v == 'PASS')
        n_fail = sum(1 for v in results.values() if v == 'FAIL')
        print(f'{n_pass} PASS, {n_fail} FAIL')

    passed, failed, total, report_path = build_report(suites_tests, all_results)
    print(f'\nReport saved: {report_path}')
    print(f'\nResult: {passed}/{total} passed, {failed} failed.')


if __name__ == '__main__':
    main()
