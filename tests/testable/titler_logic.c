#include <string.h>
#include <stdbool.h>

#include "MenuFunctions.h"

extern char titlerBuf[TitlerBufLen];
extern signed char titlerCursorX;
extern signed char titlerCursorY;
extern char titlerEditMode;
extern bool titlerOn;
extern char movingOSD;
extern char saveFlag;

void Display(const char *buff);
void Save_Titler(void);
void MoveTitler(char movingOSD, int xChange, int yChange);


/**
 * @brief Clears titler buffer
 * 
 */
void ClearTitlerBuf(void)
{
    memset(titlerBuf, ' ', TitlerBufLen);
}

/**
 * @brief Moves the titler cursor as if a enter has been input
 * 
 */
void EnterTitlerCursor()
{ // Enter value brings to next line
	char currX = 0;
	char currY = titlerCursorY;

	currY++;
	if(currY >= MAX_STRINGS)
	{
		currY = 0;
	}
	
	titlerCursorX = currX;
	titlerCursorY = currY;
}

/**
 * @brief Moves the titler cursor as if a backspace has been input
 * 
 */
void BackTitlerCursor()
{// Adds on space character duh
	char currX = titlerCursorX;
	char currY = titlerCursorY;

	currX--;
	if(currX < 0)
	{
		currX = MAX_STRING_LENGTH - 2;
		currY--;
		if(currY < 0)
		{
			currY = MAX_STRINGS-1;
		}
	}

	titlerCursorX = currX;
	titlerCursorY = currY;
}

/**
 * @brief Moves the titler cursor as if a normal keystroke has been pressed (A, 1, SPACE, etc...)
 * 
 */
void SpaceTitlerCursor()
{// Adds on space character duh
	char currX = titlerCursorX;
	char currY = titlerCursorY;

	currX++;
	if(currX >= MAX_STRING_LENGTH - 1)
	{
		currX = 0;
		currY++;
		if(currY >= MAX_STRINGS)
		{
			currY = 0;
		}
	}

	titlerCursorX = currX;
	titlerCursorY = currY;
}

//Input a char character as a keystroke and add to the buf, move cursor, special functions, etc

/**
 * @brief Takes in a character as a keystroke to the titler and adds to the buffer, moves cursor, or does special functions accordingly.
 * 
 * @param input unsigned char, ASCII or "TK_KEY"
 */
void TitlerFunction(unsigned char input)
{
	char warningMessage[27];
	int bufPos = titlerCursorX + titlerCursorY*(MAX_STRING_LENGTH - 1);

	if(titlerEditMode && titlerOn)
	{
		switch (input)
		{
			// Printable ASCII range
			default:
				if (input >= 0x21 && input <= 0x7E) 
				{
					titlerBuf[bufPos] = input;
					SpaceTitlerCursor();
				}
				break;

			// Space
			case TK_SPACE:
				titlerBuf[bufPos] = TK_SPACE;
				SpaceTitlerCursor();
				break;

			// Enter
			case TK_ENTER:
				EnterTitlerCursor();
				break;

			// Backspace
			case TK_BCK:
				BackTitlerCursor();
				bufPos = titlerCursorX + titlerCursorY * (MAX_STRING_LENGTH - 1);
				titlerBuf[bufPos] = TK_SPACE;
				break;

			// Delete
			case TK_DEL:
				titlerBuf[bufPos] = TK_SPACE;
				break;

			// Home
			case TK_HOME:
				titlerCursorX = 0;
				titlerCursorY = 0;

				break;

			// Clear (F4)
			case TK_F4:
				ClearTitlerBuf();
				//Display("Proc: Titler Cleared");  
				break;

			case TK_F5:
				Save_Titler();

				strcpy (&warningMessage, "Proc: Titler Saved");
				Display(&warningMessage);  

				break;

			case TK_UP: //Move around freely
				if(movingOSD)
				{
					MoveTitler(movingOSD, 0, -1);
				}
				else
				{
					titlerCursorY--;
					if(titlerCursorY < 0){titlerCursorY = MAX_STRINGS - 1;}
				}
				break;
			case TK_DOWN:
				if(movingOSD)
				{
					MoveTitler(movingOSD, 0, 1);
				}
				else
				{
					titlerCursorY++;
					if(titlerCursorY > MAX_STRINGS - 1){titlerCursorY = 0;}
				}
				break;
			case TK_LEFT:
				if(movingOSD)
				{
					MoveTitler(movingOSD, -1, 0);
				}
				else
				{
					titlerCursorX--;
					if(titlerCursorX < 0){titlerCursorX = MAX_STRING_LENGTH - 2;}
				}
				break;
			case TK_RIGHT:
				if(movingOSD)
				{
					MoveTitler(movingOSD, 1, 0);
				}
				else
				{
					titlerCursorX++;
					if(titlerCursorX > MAX_STRING_LENGTH - 2){titlerCursorX = 0;}
				}

				break;
		}
	}

	

	if(input == TK_F2) //Toggle edit mode
	{
		if(titlerEditMode == 1)
		{
			titlerEditMode = 0;
			strcpy (&warningMessage, "Proc: Titler Editing OFF");
			Display(&warningMessage);  

			
		}
		else
		{
			strcpy (&warningMessage, "Proc: Titler Editing ON");
			Display(&warningMessage);  

			titlerEditMode = 1;
		}

	}
	if(input == TK_F12)
	{
		if(titlerOn)
		{
			strcpy (&warningMessage, "Proc: Titler Display OFF");
			Display(&warningMessage);  
			movingOSD = 0;
			titlerOn = false;
		}
		else
		{
			strcpy (&warningMessage, "Proc: Titler Display ON");
			Display(&warningMessage);  

			titlerOn = true;
		}
	}
	if(input == TK_F7)
	{
		if(titlerEditMode)
		{
			switch (movingOSD)
			{
				case 0: 
					movingOSD = MDIN_TITLER;
					strcpy (&warningMessage, "Proc: CALIBRATING TITLER");
					Display(&warningMessage);  
					break;
				case MDIN_TITLER: 
					movingOSD = MDIN_WARNING;
					strcpy (&warningMessage, "Proc: CALIBRATING MENU");
					Display(&warningMessage);  
					break;
				case MDIN_WARNING: 
					movingOSD = 0;
					strcpy (&warningMessage, "Proc: CALIBRATING OFF");
					Display(&warningMessage);  
					saveFlag = 1;
					break;

			}
		}
	}




}

/**
 * @brief Translates a HID input key into an equivalent char or "TK_KEY" 
 * 
 * @param tran char, HID input that is to be translated
 * @param shift char, 1 indicates shift key is held, otherwise 0 
 * @return char, Printable character or "TK_KEY" that can be used by the TitlerFunction
 */
char TranslateTitlerKeys(char tran, char shift) 
{

    // Letters (HID 0x04–0x1D)
    if (tran >= HID_A && tran <= HID_Z) 
	{
        char base = 'a' + (tran - 0x04);
        return shift ? (base - 'a' + 'A') : base;
    }

    // Digits top row (HID 0x1E–0x27)
    switch (tran) 
	{
        case HID_1: return shift ? '!' : '1';
        case HID_2: return shift ? '@' : '2';
        case HID_3: return shift ? '#' : '3';
        case HID_4: return shift ? '$' : '4';
        case HID_5: return shift ? '%' : '5';
        case HID_6: return shift ? '^' : '6';
        case HID_7: return shift ? '&' : '7';
        case HID_8: return shift ? '*' : '8';
        case HID_9: return shift ? '(' : '9';
        case HID_0: return shift ? ')' : '0';
    }

    // Whitespace / simple ASCII
    switch (tran) 
	{//Not any real translating happening here
        case HID_SPACE: return TK_SPACE;    // Space
        case HID_ENTER: return TK_ENTER;   // Enter
        case HID_BACKSPACE: return TK_BCK;   // Backspace
    }

    // Punctuation (US ANSI)
    switch (tran) 
	{
        case HID_MINUS: return shift ? '_' : '-';
        case HID_EQUAL: return shift ? '+' : '=';
        case HID_LBRACKET: return shift ? '{' : '[';
        case HID_RBRACKET: return shift ? '}' : ']';
        case HID_BACKSLASH: return shift ? '|' : '\\';
        case HID_SEMICOLON: return shift ? ':' : ';';
        case HID_APOSTROPHE: return shift ? '"' : '\'';
        case HID_GRAVE: return shift ? '~' : '`';
        case HID_COMMA: return shift ? '<' : ',';
        case HID_PERIOD: return shift ? '>' : '.';
        case HID_SLASH: return shift ? '?' : '/';
    }

	switch (tran)
	{
		case HID_UP: return TK_UP;
		case HID_DOWN: return TK_DOWN;
		case HID_LEFT: return TK_LEFT;
		case HID_RIGHT: return TK_RIGHT;
		case HID_HOME: return TK_HOME;
		case HID_DELETE: return TK_DEL;
		case HID_F1 :  return TK_F1;
		case HID_F2  : return TK_F2;  
		case HID_F3  : return TK_F3;  
		case HID_F4  : return TK_F4;
		case HID_F5  : return TK_F5;
		case HID_F6  : return TK_F6;
		case HID_F7  : return TK_F7;
		case HID_F8  : return TK_F8;
		case HID_F9  : return TK_F9;
		case HID_F10 : return TK_F10;
		case HID_F11 : return TK_F11;
		case HID_F12 : return TK_F12;
	}

    return TK_NONE;
}

/**
 * @brief Indicates whether a HID input has the shift key held
 * 
 * Notes: Usually HID outputs multiple chars for multiple keys held on keyboard.
 * Only the first char needs to be checked for the shift key.
 * 
 * @param tran HID input char
 * @return char, 1 indicates shift is held, otherwise 0
 */
char ShiftKeys(char tran)
{

	if((tran & (HID_MOD_LSHIFT | HID_MOD_RSHIFT)) != 0)
	{
		return 1;
	}
    return 0;
}



