# Automated tests

`test_cammenu.c` contains 26 Unity tests for the production camera-menu logic.
`run_tests.py` runs those tests and then exercises the real PC host through its
UDP CAN boundary.

Run `python run_tests.py` here, or select **Test: Camera PC Regression** from
VS Code's **Run Task** menu.
