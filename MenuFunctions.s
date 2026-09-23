	.module MenuFunctions.c
	.area text
	.dbfile ..\REV1~1.01\MenuFunctions.c
	.area data
	.dbfile ..\REV1~1.01\MenuFunctions.c
_UpdateArrayVar::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile ..\REV1~1.01\MenuFunctions.c
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbsym e UpdateArrayVar _UpdateArrayVar c
_StoreFlag::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbsym e StoreFlag _StoreFlag c
	.area text
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e NullFunction _NullFunction fI
_NullFunction::
	.dbline -1
	.dbline 63
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; #include <math.h>
; 
; #include "Camera.h"
; #include "nodecfg.h"
; #include "Subroutines.h"
; #include "mc9s12a128.h"
; #include "Interrupts.h"
; #include "mco.h"
; #include "mcohw.h"
; #include "EEProm.h"
; #include "MenuFunctions.h"
; 
; 
; extern char Variable_flag;
; extern char String_Var_ptr;
; extern char Multi_Var_ptr;
; extern struct MenuStack MenuStackc[];
; extern char StackPointer;
; extern char Menu[12][21];
; extern char Gen_Flags;
; extern unsigned int cam_add;
; 
; extern UNSIGNED8 gProcImg[]; 
; extern CAN_MSG gTxMsg;
; extern unsigned int TC0_RCVD_Data;
; 
; extern struct menu_var SerialNum;
; extern struct menu_var NullVar;
; extern struct menu_var NullVar2;
; extern struct menu_var MicOnOff;
; extern struct menu_var CamTag;
; char EE_CamTag[STR_VALUE_LEN];
; 
; extern const int EG_defaults[]; 
; extern const int LG_defaults[]; 
; extern const double GR_defaults[];
; 
; char CursorDownFlag;
; char CursorUpFlag;
; char SelectFlag;
; extern char UpdateMenu;
; 
; extern unsigned int Timer1;
; extern unsigned int MenuTimer;
; extern unsigned int IncSpeedUpTimer;
; 
; extern char fast_inc;
; 
; char UpdateArrayVar = 0;
; 
; 
; char AcceptKeys;
; char InProcess;
; char StoreFlag = 0;
; extern char State;
; 
; 
; 
; int NullFunction ( void )
; {
	.dbline 64
;     return 0;
	ldd #0
	.dbline -2
L6:
	.dbline 0 ; func end
	rts
	.dbend
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbstruct 0 34 menu_var
	.dbfield 0 value D
	.dbfield 4 inc D
	.dbfield 8 min D
	.dbfield 12 max D
	.dbfield 16 dec_pos c
	.dbfield 17 len_str C
	.dbfield 18 str_value A[12:12]c
	.dbfield 30 str_enum pc
	.dbfield 32 next_var pS[menu_var]
	.dbend
	.dbfunc e getVariable _getVariable fpS[menu_var]
;              k -> 8,SP
;              j -> 10,SP
;            var -> 12,SP
$_getVariable::
	leas -14,S
	.dbline -1
	.dbline 69
; }
; 
; //This gets the variable pointed to by the Menu/Cursor/Multi_Var_ptr
; struct menu_var *getVariable( void ) 
; {
	.dbline 71
;      int k;
; 	 int j=1;
	movw #1,10,S
	.dbline 74
; 	 struct menu_var *var; 
; 	 
; 	 k = FindMenu();
	xcall $_FindMenu
	clra
	tfr D,Y
	sty 8,S
	.dbline 75
; 	 var = Menuc[k].VarPntr[MenuStackc[StackPointer].CursorPos+MenuStackc[StackPointer].FirstLine-1];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 6,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 4,S
	ldd 6,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 4,S
	tfr Y,D
	stx 0,S
	addd 0,S
	subd #1
	lsld
	std 2,S
	ldy 8,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+267
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 0,Y,12,S
	bra L12
L11:
	.dbline 77
; 	 while(j<Multi_Var_ptr)
; 	 {
	.dbline 78
; 	     var = var->next_var;
	ldy 12,S
	leay 32,Y
	movw 0,y,12,S
	.dbline 79
; 		 j++;
	ldy 10,S
	iny
	sty 10,S
	.dbline 80
; 	 }
L12:
	.dbline 76
	ldab _Multi_Var_ptr
	clra
	cpd 10,S
	bgt L11
	.dbline 81
;      return var;
	ldd 12,S
	.dbline -2
L7:
	.dbline 0 ; func end
	leas 14,S
	rtc
	.dbsym l k 8 I
	.dbsym l j 10 I
	.dbsym l var 12 pS[menu_var]
	.dbend
	.dbfunc e StdVarFunc_String _StdVarFunc_String fV
;      old_value -> 4,SP
;            var -> 8,SP
$_StdVarFunc_String::
	pshd
	leas -8,S
	.dbline -1
	.dbline 86
; }
; 
; //This displays the "String Type" variable with a '-' in the current "String_Var_ptr" location
; void StdVarFunc_String ( struct menu_var *var ) 
; {
	.dbline 89
; 	float old_value; 
; 	
;     getvalue(var,String_Var_ptr-1);
	ldab _String_Var_ptr
	tfr B,Y
	dey
	tfr Y,D
	clra
	std 0,S
	ldd 8,S
	xcall $_getvalue
	leas 4,S
	.dbline 90
;     old_value = var->value;
	ldy 8,S
	movw 0,Y,4,S
	movw 2,Y,6,S
	.dbline 91
;     var->value = var->max+1; 	 //the last char in the enum list is used as a cursor
	ldd 8,S
	addd #12
	tfr D,X
	ldy 8,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr addf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 92
;     getstrval(var);				 //put it in the string temporarily   
	ldd 8,S
	xcall $_getstrval
	.dbline 93
;     LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 2,S
	addd 2,S
	xcall $_LoadMenu
	.dbline 94
;     var->value = old_value;
	ldy 8,S
	ldd 6,S
	pshd
	ldd 6,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 95
;     getstrval(var);
	ldd 8,S
	xcall $_getstrval
	.dbline -2
L14:
	.dbline 0 ; func end
	leas 10,S
	rtc
	.dbsym l old_value 4 D
	.dbsym l var 8 pS[menu_var]
	.dbend
	.dbfunc e next_variable _next_variable fV
;            var -> 2,SP
$_next_variable::
	pshd
	leas -2,S
	.dbline -1
	.dbline 100
; }
; 
; // This puts the next variable in the Menu and updates the pointers "Multi_Var_ptr", "String_Var_ptr", "Variable_flag"
; void next_variable ( struct menu_var *var )
; {
	.dbline 101
;     if (var->next_var) // See if more linked variables
	ldd 2,S
	addd #32
	tfr D,Y
	ldy 0,Y
	cpy #0
	beq L16
	.dbline 102
;     {
	.dbline 103
;         Multi_Var_ptr++;
	inc _Multi_Var_ptr
	.dbline 104
;         var = getVariable();   // Get the variable pointed to by Multi_Var_ptr
	xcall $_getVariable
	tfr D,X
	stx 2,S
	.dbline 105
;         if (var->len_str < 0)  // See if "String Type"
	tfr X,D
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bge L18
	.dbline 106
;         {
	.dbline 107
;             String_Var_ptr = 1;
	movb #1,_String_Var_ptr
	.dbline 108
;             StdVarFunc_String(var); //Display "String Type"   ">-xxx"
	ldd 2,S
	xcall $_StdVarFunc_String
	.dbline 109
;         }
	bra L17
L18:
	.dbline 111
;     	else //"Standard" numeric or enum variable here
;     	{
	.dbline 112
;             if (!Multi_Var_ptr)
	ldab _Multi_Var_ptr
	cmpb #0
	bne L20
	.dbline 113
;                 Variable_flag = 0; //This removes Variable Cursor when the menu is loaded
	clr _Variable_flag
L20:
	.dbline 115
; 			
;         	LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 116
;         	if (!Multi_Var_ptr)
	ldab _Multi_Var_ptr
	cmpb #0
	bne L17
	.dbline 117
;                 InsertCursor ();
	xcall $_InsertCursor
	.dbline 118
;         }
	.dbline 120
; 	
;     }
	bra L17
L16:
	.dbline 122
; 	else // No more linked variables, cursor back to beginning of line
; 	{
	.dbline 123
; 	    Variable_flag = 0;
	clr _Variable_flag
	.dbline 124
; 		Multi_Var_ptr = 0;
	clr _Multi_Var_ptr
	.dbline 125
; 		String_Var_ptr = 0;
	clr _String_Var_ptr
	.dbline 126
; 		UpdateArrayVar = 0;
	clr _UpdateArrayVar
	.dbline 127
; 		LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 128
; 		InsertCursor ();
	xcall $_InsertCursor
	.dbline 129
; 	}
L17:
	.dbline -2
L15:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l var 2 pS[menu_var]
	.dbend
	.dbfunc e Next_Char_In_String_Var _Next_Char_In_String_Var fV
;              i -> 3,SP
;            var -> 5,SP
$_Next_Char_In_String_Var::
	pshd
	leas -5,S
	.dbline -1
	.dbline 135
;     
; }
; 
; // This points to the next char in "String Type" variables and puts in Menu, or goes to next variable
; void Next_Char_In_String_Var ( struct menu_var *var ) 
; {
	.dbline 138
;     int i;
; 	
;     if (++String_Var_ptr > abs(var->len_str)) //End of "String Type" variable here
	ldab _String_Var_ptr
	tfr B,Y
	iny
	tfr Y,B
	stab 2,S
	ldd 5,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,D
	movb 2,S,_String_Var_ptr
	xcall $_abs
	tfr D,X
	stx 0,S
	ldab 2,S
	clra
	cpd 0,S
	ble L25
	.dbline 139
;     {
	.dbline 140
; 	    next_variable (var);
	ldd 5,S
	xcall $_next_variable
	.dbline 141
;     }
	bra L26
L25:
	.dbline 143
;     else
;     {
	.dbline 144
; 	    StdVarFunc_String(var);
	ldd 5,S
	xcall $_StdVarFunc_String
	.dbline 145
;     }
L26:
	.dbline -2
L24:
	.dbline 0 ; func end
	leas 7,S
	rtc
	.dbsym l i 3 I
	.dbsym l var 5 pS[menu_var]
	.dbend
	.dbfunc e ArrayVarFunction _ArrayVarFunction fI
$_ArrayVarFunction::
	.dbline -1
	.dbline 152
; 
; }
; 
; //When a menu item is first select, this sets the UpdateArrayVar to cause 
; //a variable array to be update
; int ArrayVarFunction ( void )
; {
	.dbline 153
;     UpdateArrayVar = 8;
	movb #8,_UpdateArrayVar
	.dbline 154
; 	return StdVarFunction();
	jsr _StdVarFunction
	.dbline -2
L27:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e UpdateArrayVariables _UpdateArrayVariables fV
;              i -> 8,SP
;        tempstr -> 10,SP
;            num -> 28,SP
;            var -> 22,SP
$_UpdateArrayVariables::
	pshd
	leas -22,S
	.dbline -1
	.dbline 158
; }
; 
; void UpdateArrayVariables ( struct menu_var *var, char num )
; {
	.dbline 160
;     char tempstr[12];
;     int i=0;
	movw #0,8,S
	.dbline 162
;     
; 	if (num)
	ldab 28,S
	cmpb #0
	lbeq L29
	.dbline 163
; 	{
	.dbline 164
;         var = getVariable();
	xcall $_getVariable
	tfr D,X
	stx 22,S
	.dbline 165
;         strncpy (tempstr,&var->str_value[0],sizeof(tempstr));
	ldy #12
	sty 2,S
	ldd 22,S
	addd #18
	std 0,S
	leay 10,S
	tfr Y,D
	xcall $_strncpy
	bra L32
L31:
	.dbline 167
;         while (i++ < num-1)
;         {
	.dbline 168
;             var++;
	ldd 22,S
	addd #34
	std 22,S
	.dbline 169
;         	strncpy (&var->str_value[0],tempstr,var->len_str);
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	sty 2,S
	leay 10,S
	sty 0,S
	ldd 22,S
	addd #18
	xcall $_strncpy
	.dbline 170
;         	getvalue(var,0);
	ldy #0
	sty 0,S
	ldd 22,S
	xcall $_getvalue
	leas 4,S
	.dbline 171
;         }
L32:
	.dbline 166
	movw 8,S,6,S
	ldy 6,S
	iny
	sty 8,S
	ldab 28,S
	clra
	tfr D,Y
	dey
	cpy 6,S
	bgt L31
	.dbline 172
; 		LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 4,S
	addd 4,S
	xcall $_LoadMenu
	.dbline 173
; 		DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 174
; 	}
L29:
	.dbline -2
L28:
	.dbline 0 ; func end
	leas 24,S
	rtc
	.dbsym l i 8 I
	.dbsym l tempstr 10 A[12:12]c
	.dbsym l num 28 c
	.dbsym l var 22 pS[menu_var]
	.dbend
	.dbfunc e SkipVarFunction _SkipVarFunction fI
;            var -> 8,SP
;              i -> 10,SP
$_SkipVarFunction::
	leas -12,S
	.dbline -1
	.dbline 180
; }
; 
; //When a menu item is first select, this skips the first variable on the line (multi-variable)
; //The first variable can be used to display info such as temperature
; int SkipVarFunction ( void )
; {
	.dbline 184
;     int i;
; 	struct menu_var *var;
; 	
; 	if ( !Variable_flag ) //Here the first time select is pushed
	ldab _Variable_flag
	cmpb #0
	lbne L35
	.dbline 185
; 	{
	.dbline 186
; 	    i = FindMenu(); 
	xcall $_FindMenu
	clra
	tfr D,Y
	sty 10,S
	.dbline 187
; 	    var = Menuc[i].VarPntr[MenuStackc[StackPointer].CursorPos+MenuStackc[StackPointer].FirstLine-1];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 6,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 4,S
	ldd 6,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 4,S
	tfr Y,D
	stx 0,S
	addd 0,S
	subd #1
	lsld
	std 2,S
	ldy 10,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+267
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 0,Y,8,S
	.dbline 189
; 	    //var is the 1st variable pointed to in the menu
; 		next_variable( var );
	ldd 8,S
	xcall $_next_variable
	.dbline 191
; 		
; 		Variable_flag = 1;
	movb #1,_Variable_flag
	.dbline 192
; 	}
L35:
	.dbline 194
;     
; 	return StdVarFunction();
	jsr _StdVarFunction
	.dbline -2
L34:
	.dbline 0 ; func end
	leas 12,S
	rtc
	.dbsym l var 8 pS[menu_var]
	.dbsym l i 10 I
	.dbend
	.area text
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e StdVarFunction _StdVarFunction fI
;      old_value -> 8,SP
;              i -> 12,SP
;            var -> 14,SP
_StdVarFunction::
	leas -16,S
	.dbline -1
	.dbline 199
; }
; 
; //When a menu item is first select, this sets the Variable
; int StdVarFunction ( void )
; {
	.dbline 204
;     int i;
; 	struct menu_var *var;
; 	float old_value; 
; 	
; 	i = FindMenu(); 
	xcall $_FindMenu
	clra
	tfr D,Y
	sty 12,S
	.dbline 205
; 	var = Menuc[i].VarPntr[MenuStackc[StackPointer].CursorPos+MenuStackc[StackPointer].FirstLine-1];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 6,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 4,S
	ldd 6,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 4,S
	tfr Y,D
	stx 0,S
	addd 0,S
	subd #1
	lsld
	std 2,S
	ldy 12,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+267
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 0,Y,14,S
	.dbline 209
; 	    //var is the 1st variable pointed to in the menu
; 	
; 	
; 	if ( !Variable_flag ) //Here the first time select is pushed
	ldab _Variable_flag
	cmpb #0
	bne L44
	.dbline 210
;     {
	.dbline 211
; 		Variable_flag = 1;
	movb #1,_Variable_flag
	.dbline 212
; 		Multi_Var_ptr = 0;
	clr _Multi_Var_ptr
	.dbline 213
; 		String_Var_ptr = 0;
	clr _String_Var_ptr
	.dbline 215
; 		
;         if (var->next_var)
	ldd 14,S
	addd #32
	tfr D,Y
	ldy 0,Y
	cpy #0
	beq L46
	.dbline 216
; 		    Multi_Var_ptr = 1;
	movb #1,_Multi_Var_ptr
L46:
	.dbline 218
; 			
; 		if ( var->len_str < 0 )	//puts a cursor char in "String type" variables <<<<<<<<<<<<<<<<<<
	ldd 14,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bge L48
	.dbline 219
; 		{
	.dbline 220
;     		String_Var_ptr = 1;
	movb #1,_String_Var_ptr
	.dbline 221
; 			StdVarFunc_String(var);
	ldd 14,S
	xcall $_StdVarFunc_String
	.dbline 222
; 		}
	bra L45
L48:
	.dbline 224
; 		else			   //non "String type" variables
; 		{
	.dbline 225
;             LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 226
; 		}
	.dbline 227
;     }
	bra L45
L44:
	.dbline 229
;     else //Here if select had already been pushed, see if more variables or string variable, or end if needed
;     {
	.dbline 231
; 
; 	    var = getVariable();// Get the variable pointed to by Multi_Var_ptr
	xcall $_getVariable
	tfr D,X
	stx 14,S
	.dbline 234
; 		 
; 		//see if "String type" before going to next multi var
; 		if (var->len_str < 0) //"String type"
	tfr X,D
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bge L50
	.dbline 235
; 		{
	.dbline 236
; 		    Next_Char_In_String_Var( var );  
	ldd 14,S
	xcall $_Next_Char_In_String_Var
	.dbline 237
; 		}
	bra L51
L50:
	.dbline 239
; 		else
; 		{
	.dbline 240
; 		    next_variable( var );
	ldd 14,S
	xcall $_next_variable
	.dbline 241
; 		}
L51:
	.dbline 242
;     }
L45:
	.dbline 245
; 
; 
;     DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 246
;     return 0;
	ldd #0
	.dbline -2
L40:
	.dbline 0 ; func end
	leas 16,S
	rts
	.dbsym l old_value 8 D
	.dbsym l i 12 I
	.dbsym l var 14 pS[menu_var]
	.dbend
	.dbfunc e SerVarFunction _SerVarFunction fI
;              i -> 10,SP
;            var -> 12,SP
_SerVarFunction::
	leas -14,S
	.dbline -1
	.dbline 250
; }
; 
; int SerVarFunction ( void )
; {
	.dbline 254
;     int i; 
; 	struct menu_var *var;
; 
;     if (*(char *)0xB10 >= '0' && *(char *)0xB10 <= '9')
	ldab 0xb10
	clra
	std 8,S
	cpd #48
	blt L53
	ldy 8,S
	cpy #57
	bgt L53
	.dbline 255
; 	{
	.dbline 256
; 	    return 0;
	ldd #0
	lbra L52
L53:
	.dbline 259
; 	}	
; 
; 	i = FindMenu(); 
	xcall $_FindMenu
	clra
	tfr D,Y
	sty 10,S
	.dbline 260
; 	var = Menuc[i].VarPntr[MenuStackc[StackPointer].CursorPos+MenuStackc[StackPointer].FirstLine-1];   //var is the 1st variable pointed to in the menu
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 6,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 4,S
	ldd 6,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 4,S
	tfr Y,D
	stx 0,S
	addd 0,S
	subd #1
	lsld
	std 2,S
	ldy 10,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+267
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	movw 0,Y,12,S
	.dbline 262
; 	    
; 	if (!Variable_flag) //Here the first time select is pushed
	ldab _Variable_flag
	cmpb #0
	bne L58
	.dbline 263
;     {
	.dbline 264
; 		Variable_flag = 1;
	movb #1,_Variable_flag
	.dbline 265
;     	String_Var_ptr = 1;
	movb #1,_String_Var_ptr
	.dbline 266
; 		StdVarFunc_String(var);
	ldd 12,S
	xcall $_StdVarFunc_String
	.dbline 267
; 	}
	bra L59
L58:
	.dbline 269
; 	else  //Here if select had already been pushed, see if more variables or string variable, or end if needed
; 	{
	.dbline 270
; 	   var = getVariable();  // Get the variable pointed to
	xcall $_getVariable
	tfr D,X
	stx 12,S
	.dbline 271
; 	   Next_Char_In_String_Var(var); 
	tfr X,D
	xcall $_Next_Char_In_String_Var
	.dbline 272
; 	}
L59:
	.dbline 274
; 
;     DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 275
;  	return 0;
	ldd #0
	.dbline -2
L52:
	.dbline 0 ; func end
	leas 14,S
	rts
	.dbsym l i 10 I
	.dbsym l var 12 pS[menu_var]
	.dbend
	.dbfunc e ExitMenu _ExitMenu fI
_ExitMenu::
	.dbline -1
	.dbline 280
; }
; 
; 
; int ExitMenu ( void )
; {
	.dbline 281
;     DeSelect ();
	xcall $_DeSelect
	.dbline 282
;     return 0;
	ldd #0
	.dbline -2
L60:
	.dbline 0 ; func end
	rts
	.dbend
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e CursorUp _CursorUp fV
$_CursorUp::
	leas -8,S
	.dbline -1
	.dbline 287
; }
; 
; 
; void CursorUp( void )
; {
	.dbline 288
;     if ( Variable_flag )
	ldab _Variable_flag
	cmpb #0
	beq L62
	.dbline 289
;     {
	.dbline 290
;          IncVariable ();
	xcall $_IncVariable
	.dbline 291
; 		 UpdateArrayVariables (getVariable(),UpdateArrayVar); 	
	xcall $_getVariable
	tfr D,X
	stx 6,S
	ldab _UpdateArrayVar
	clra
	std 0,S
	ldd 6,S
	xcall $_UpdateArrayVariables
	.dbline 292
;     }
	bra L63
L62:
	.dbline 294
;     else
;     {
	.dbline 295
;        MenuStackc[StackPointer].CursorPos--;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 2,S
	addd 2,S
	tfr D,Y
	sty 4,S
	ldab [4,S]
	tfr B,Y
	dey
	ldx 4,S
	tfr Y,B
	stab 0,X
	.dbline 296
;        LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 2,S
	addd 2,S
	xcall $_LoadMenu
	.dbline 297
;        InsertCursor ();
	xcall $_InsertCursor
	.dbline 298
;        DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 299
;     }
L63:
	.dbline -2
L61:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbend
	.dbfunc e CursorDown _CursorDown fV
$_CursorDown::
	leas -8,S
	.dbline -1
	.dbline 303
; }
; 
; void CursorDown( void )
; {
	.dbline 304
;     if ( Variable_flag )
	ldab _Variable_flag
	cmpb #0
	beq L66
	.dbline 305
;     {
	.dbline 306
;          DecVariable ();
	xcall $_DecVariable
	.dbline 307
; 		 UpdateArrayVariables (getVariable(),UpdateArrayVar);
	xcall $_getVariable
	tfr D,X
	stx 6,S
	ldab _UpdateArrayVar
	clra
	std 0,S
	ldd 6,S
	xcall $_UpdateArrayVariables
	.dbline 308
;     }
	bra L67
L66:
	.dbline 310
;     else
;     {
	.dbline 311
;        MenuStackc[StackPointer].CursorPos++;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 2,S
	addd 2,S
	tfr D,Y
	sty 4,S
	ldab [4,S]
	tfr B,Y
	iny
	ldx 4,S
	tfr Y,B
	stab 0,X
	.dbline 312
;        LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 2,S
	addd 2,S
	xcall $_LoadMenu
	.dbline 313
;        InsertCursor ();
	xcall $_InsertCursor
	.dbline 314
;        DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 315
;     }
L67:
	.dbline -2
L65:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbend
	.dbfunc e getvalue _getvalue fD
;        tempstr -> 10,SP
;          token -> 130,SP
;              i -> 132,SP
;          index -> 140,SP
;            var -> 134,SP
$_getvalue::
	pshd
	leas -134,S
	.dbline -1
	.dbline 322
; }
; 
; //Updates and returns the value member corresponding to the str_value member
; //-OR- gets the enum number corresponding to the str_value member
; //-OR- gets the enum number of the char pointed to by index for "String type" variables
; float getvalue (struct menu_var* var, char index)
; {
	.dbline 327
;     char tempstr[120];
;     char *token;
;     int i;
; 
;     if (strlen(var->str_enum) && var->len_str >= 0) //regular enum list
	ldd 134,S
	addd #30
	tfr D,Y
	ldd 0,Y
	xcall $_strlen
	cpd #0
	lbeq L70
	ldd 134,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lblt L70
	.dbline 328
;     {
	.dbline 329
;         strncpy(tempstr,var->str_enum,sizeof(tempstr));
	ldy #120
	sty 2,S
	ldd 134,S
	addd #30
	tfr D,Y
	ldy 0,Y
	sty 0,S
	leay 10,S
	tfr Y,D
	xcall $_strncpy
	.dbline 331
; 
;         for (i=1;i<=var->max;i++)
	leax 132,S
	movw #1,0,x
	bra L75
L72:
	.dbline 332
;         {
	.dbline 333
;             if (i==1)
	ldy 132,S
	cpy #1
	bne L76
	.dbline 334
;                 token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 10,S
	tfr Y,D
	xcall $_strtok
	std 130,S
	bra L77
L76:
	.dbline 336
;             else
;                 token = strtok(NULL, ",");
	ldy #L78
	sty 0,S
	ldd #0
	xcall $_strtok
	std 130,S
L77:
	.dbline 338
; 
; 			if ( !strcmp(var->str_value,token) )
	ldy 130,S
	sty 0,S
	ldd 134,S
	addd #18
	xcall $_strcmp
	cpd #0
	bne L79
	.dbline 339
; 			{
	.dbline 340
; 			    var->value = i;
	ldd 132,S
	ldy 134,S
	jsr int2fp
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 341
; 				break;
	lbra L71
L79:
	.dbline 343
; 			}
;         }
L73:
	.dbline 331
	ldy 132,S
	iny
	sty 132,S
L75:
	.dbline 331
	ldd 132,S
	jsr int2fp
	ldd 138,S
	addd #12
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr cmpf4
	lble L72
	.dbline 344
; 	}
	lbra L71
L70:
	.dbline 345
; 	else if (strlen(var->str_enum) && var->len_str < 0) //"String type" enum list
	ldd 134,S
	addd #30
	tfr D,Y
	ldd 0,Y
	xcall $_strlen
	cpd #0
	lbeq L81
	ldd 134,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbge L81
	.dbline 346
; 	{
	.dbline 347
;         strncpy(tempstr,var->str_enum,sizeof(tempstr));
	ldy #120
	sty 2,S
	ldd 134,S
	addd #30
	tfr D,Y
	ldy 0,Y
	sty 0,S
	leay 10,S
	tfr Y,D
	xcall $_strncpy
	.dbline 349
; 
;         for (i=1;i<=var->max;i++)
	leax 132,S
	movw #1,0,x
	lbra L86
L83:
	.dbline 350
;         {
	.dbline 351
;             if (i==1)
	ldy 132,S
	cpy #1
	bne L87
	.dbline 352
;                 token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 10,S
	tfr Y,D
	xcall $_strtok
	std 130,S
	bra L88
L87:
	.dbline 354
;             else
;                 token = strtok(NULL, ",");
	ldy #L78
	sty 0,S
	ldd #0
	xcall $_strtok
	std 130,S
L88:
	.dbline 356
; 
; 			if ( *(var->str_value+index) == *token )
	ldd 134,S
	addd #18
	tfr D,Y
	ldab 140,S
	clra
	sty 4,S
	addd 4,S
	tfr D,Y
	ldab 0,Y
	cmpb [130,S]
	bne L89
	.dbline 357
; 			{
	.dbline 358
; 			    var->value = i;
	ldd 132,S
	ldy 134,S
	jsr int2fp
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 359
; 				break;
	lbra L82
L89:
	.dbline 361
; 			}
;         }
L84:
	.dbline 349
	ldy 132,S
	iny
	sty 132,S
L86:
	.dbline 349
	ldd 132,S
	jsr int2fp
	ldd 138,S
	addd #12
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr cmpf4
	lble L83
	.dbline 363
; 
; 	}
	bra L82
L81:
	.dbline 364
; 	else if (strlen(var->str_enum) == 0) //"Numeric type" variable, get value of string
	ldd 134,S
	addd #30
	tfr D,Y
	ldd 0,Y
	xcall $_strlen
	cpd #0
	bne L91
	.dbline 365
;     {
	.dbline 366
;         var->value=atof(var->str_value);
	ldd 134,S
	addd #18
	jsr _atof
	puld
	std 8,S
	puld
	std 8,S
	ldy 134,S
	ldd 8,S
	pshd
	ldd 8,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 367
;     }
L91:
L82:
L71:
	.dbline 368
; 	return var->value;
	ldy 134,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	.dbline -2
L69:
	.dbline 0 ; func end
	ldd #136
	jmp lret_paged
	.dbsym l tempstr 10 A[120:120]c
	.dbsym l token 130 pc
	.dbsym l i 132 I
	.dbsym l index 140 c
	.dbsym l var 134 pS[menu_var]
	.dbend
	.dbfunc e getstrval _getstrval fpc
;        tempstr -> 24,SP
;          token -> 124,SP
;              i -> 126,SP
;            var -> 128,SP
$_getstrval::
	pshd
	leas -128,S
	.dbline -1
	.dbline 375
; }
; 
; //Creates a string from the value member or the enum member
; //assigns the string to ->str_value, left pads with space so length = ->len_str
; //also returns a pointer to the string
; char * getstrval (struct menu_var* var)
; {
	.dbline 380
;     char tempstr[100];
;     char *token;
;     int i;
; 
;     if (strlen(var->str_enum) && var->len_str >= 0) //"Enum Type" variable here
	ldd 128,S
	addd #30
	tfr D,Y
	ldd 0,Y
	xcall $_strlen
	cpd #0
	lbeq L94
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lblt L94
	.dbline 381
;     {
	.dbline 382
;         strncpy(tempstr,var->str_enum,sizeof(tempstr));
	ldy #100
	sty 2,S
	ldd 128,S
	addd #30
	tfr D,Y
	ldy 0,Y
	sty 0,S
	leay 24,S
	tfr Y,D
	xcall $_strncpy
	.dbline 383
;         token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 24,S
	tfr Y,D
	xcall $_strtok
	std 124,S
	.dbline 384
;         for (i=0;i<var->value-1;i++)
	leax 126,S
	movw #0,0,x
	bra L99
L96:
	.dbline 385
;         {
	.dbline 386
;             token = strtok(NULL, ",");
	ldy #L78
	sty 0,S
	ldd #0
	xcall $_strtok
	std 124,S
	.dbline 387
;         }
L97:
	.dbline 384
	ldy 126,S
	iny
	sty 126,S
L99:
	.dbline 384
	ldd 126,S
	jsr int2fp
	ldy 132,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr subf4
	jsr cmpf4
	blt L96
	.dbline 388
;         strncpy(var->str_value,token,var->len_str); //The enum string without leading spaces should be shorter than len(var->str_value)
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	sty 2,S
	ldy 124,S
	sty 0,S
	ldd 128,S
	addd #18
	xcall $_strncpy
	.dbline 389
; 		sprintf(tempstr,"%*s%s",10," ",var->str_value); //Use tempstr to pad with leading spaces
	ldd 128,S
	addd #18
	std 8,S
	ldy #L101
	sty 6,S
	ldy #10
	sty 4,S
	ldy #L100
	sty 2,S
	leay 24,S
	sty 0,S
	xcall $_sprintf
	.dbline 390
; 		strncpy(var->str_value,tempstr+strlen(tempstr)-abs(var->len_str),var->len_str); //put back in var->str_value
	leay 24,S
	tfr Y,D
	xcall $_strlen
	tfr D,X
	stx 22,S
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,D
	xcall $_abs
	tfr D,X
	stx 20,S
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	sty 2,S
	ldd 22,S
	leay 24,S
	sty 14,S
	addd 14,S
	subd 20,S
	std 0,S
	ldd 128,S
	addd #18
	xcall $_strncpy
	.dbline 391
;     }
	lbra L95
L94:
	.dbline 392
;     else if ( strlen(var->str_enum) && var->len_str < 0 ) //"String Type" variables here, get char (using value) from enum and put in string location indicated by String_Var_ptr 
	ldd 128,S
	addd #30
	tfr D,Y
	ldd 0,Y
	xcall $_strlen
	cpd #0
	lbeq L102
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbge L102
	.dbline 393
; 	{
	.dbline 396
; 	    
; 		
; 		strncpy(tempstr,var->str_enum,sizeof(tempstr)); 
	ldy #100
	sty 2,S
	ldd 128,S
	addd #30
	tfr D,Y
	ldy 0,Y
	sty 0,S
	leay 24,S
	tfr Y,D
	xcall $_strncpy
	.dbline 398
; 									   
;         for (i=0;i<var->value;i++)   
	leax 126,S
	movw #0,0,x
	bra L107
L104:
	.dbline 399
;         {							   
	.dbline 400
;             if (i==0)
	ldy 126,S
	cpy #0
	bne L108
	.dbline 401
; 			   token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 24,S
	tfr Y,D
	xcall $_strtok
	std 124,S
	bra L109
L108:
	.dbline 403
; 			else
; 			   token = strtok(NULL, ","); 
	ldy #L78
	sty 0,S
	ldd #0
	xcall $_strtok
	std 124,S
L109:
	.dbline 404
;         }
L105:
	.dbline 398
	ldy 126,S
	iny
	sty 126,S
L107:
	.dbline 398
	ldd 126,S
	jsr int2fp
	ldy 132,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr cmpf4
	blt L104
	.dbline 405
;         var->str_value[String_Var_ptr-1]=*token;
	ldd 128,S
	addd #18
	tfr D,Y
	ldab _String_Var_ptr
	clra
	subd #1
	sty 14,S
	addd 14,S
	tfr D,Y
	ldab [124,S]
	stab 0,Y
	.dbline 407
; 		//sprintf(var->str_value,"%*s%s",10," ",token);
; 	}
	lbra L103
L102:
	.dbline 409
; 	else //"Numeric Type" varaible
;     {
	.dbline 410
;         tempstr[0]=NULL;
	clr 24,S
	.dbline 411
; 		if (var->dec_pos)
	ldd 128,S
	addd #16
	tfr D,Y
	ldab 0,Y
	cmpb #0
	beq L110
	.dbline 412
; 		    sprintf(tempstr,"%*s%#.*f",10," ",var->dec_pos,var->value); //force decimal if float, use tempstr so it won't overflow var->str_value
	ldy 128,S
	movw 0,Y,10,S
	movw 2,Y,12,S
	ldd 128,S
	addd #16
	tfr D,Y
	ldab 0,Y
	clra
	std 8,S
	ldy #L101
	sty 6,S
	ldy #10
	sty 4,S
	ldy #L112
	sty 2,S
	leay 24,S
	sty 0,S
	xcall $_sprintf
	bra L111
L110:
	.dbline 414
;         else
; 		    sprintf(tempstr,"%*s%.*f",10," ",var->dec_pos,var->value); //don't force decimal on int, use tempstr so it won't overflow var->str_value
	ldy 128,S
	movw 0,Y,10,S
	movw 2,Y,12,S
	ldd 128,S
	addd #16
	tfr D,Y
	ldab 0,Y
	clra
	std 8,S
	ldy #L101
	sty 6,S
	ldy #10
	sty 4,S
	ldy #L113
	sty 2,S
	leay 24,S
	sty 0,S
	xcall $_sprintf
L111:
	.dbline 415
; 			strncpy(var->str_value,tempstr+strlen(tempstr)-abs(var->len_str),var->len_str); //Put back in var->str_value
	leay 24,S
	tfr Y,D
	xcall $_strlen
	tfr D,X
	stx 18,S
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,D
	xcall $_abs
	tfr D,X
	stx 16,S
	ldd 128,S
	addd #17
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	sty 2,S
	ldd 18,S
	leay 24,S
	sty 14,S
	addd 14,S
	subd 16,S
	std 0,S
	ldd 128,S
	addd #18
	xcall $_strncpy
	.dbline 416
;     }
L103:
L95:
	.dbline 418
;     
; 	return var->str_value;
	ldd 128,S
	addd #18
	.dbline -2
L93:
	.dbline 0 ; func end
	leas 130,S
	rtc
	.dbsym l tempstr 24 A[100:100]c
	.dbsym l token 124 pc
	.dbsym l i 126 I
	.dbsym l var 128 pS[menu_var]
	.dbend
	.dbfunc e FindMenu _FindMenu fc
;              k -> 14,SP
$_FindMenu::
	leas -16,S
	.dbline -1
	.dbline 422
; }
; 
; char FindMenu ( void )
; {
	.dbline 426
;      int k;
;      
;      //Find out which menu we are on
;      for ( k=0;k<MenuSize;k++ )
	movw #0,14,S
L115:
	.dbline 427
;      {
	.dbline 428
;         if ( Menuc[k].Index[0] == MenuStackc[StackPointer].Index[0] && Menuc[k].Index[1] == MenuStackc[StackPointer].Index[1] && 
	ldd #311
	ldy 14,S
	emul
	tfr D,Y
	ldx #6
	sty 12,S
	ldab _StackPointer
	clra
	tfr D,Y
	tfr X,D
	emul
	std 10,S
	ldy #_MenuStackc
	sty 0,S
	addd 0,S
	std 8,S
	ldd 12,S
	ldx #_Menuc
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 8,S
	tfr Y,B
	cmpb 0,X
	lbne L119
	ldd 10,S
	ldy #_MenuStackc+1
	sty 0,S
	addd 0,S
	std 6,S
	ldd 12,S
	ldx #_Menuc+1
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 6,S
	tfr Y,B
	cmpb 0,X
	bne L119
	ldd 10,S
	ldy #_MenuStackc+2
	sty 0,S
	addd 0,S
	std 4,S
	ldd 12,S
	ldx #_Menuc+2
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 4,S
	tfr Y,B
	cmpb 0,X
	bne L119
	ldd 10,S
	ldy #_MenuStackc+3
	sty 0,S
	addd 0,S
	std 2,S
	ldd 12,S
	ldx #_Menuc+3
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 2,S
	tfr Y,B
	cmpb 0,X
	bne L119
	.dbline 430
;              Menuc[k].Index[2] == MenuStackc[StackPointer].Index[2] && Menuc[k].Index[3] == MenuStackc[StackPointer].Index[3] )
;         {
	.dbline 431
; 		    break;
	bra L117
L119:
	.dbline 433
; 		}
; 	 }
L116:
	.dbline 426
	ldy 14,S
	iny
	sty 14,S
	.dbline 426
	cpy #6
	lblt L115
L117:
	.dbline 434
; 	 return k;
	ldd 14,S
	clra
	.dbline -2
L114:
	.dbline 0 ; func end
	leas 16,S
	rtc
	.dbsym l k 14 I
	.dbend
	.dbfunc e IncVariable _IncVariable fV
$_IncVariable::
	leas -2,S
	.dbline -1
	.dbline 438
; }
; 
; void IncVariable ( void )
; {
	.dbline 439
; 	 incvar(getVariable());
	xcall $_getVariable
	xcall $_incvar
	.dbline 440
;      LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 441
;      DisplayTitler ();
	xcall $_DisplayTitler
	.dbline -2
L127:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbend
	.dbfunc e incvar _incvar fpc
;            var -> 2,SP
$_incvar::
	pshd
	leas -2,S
	.dbline -1
	.dbline 449
; }
; 
; //Increments a variable using the inc member
; //Wraps around to min value if max value is exceeded
; //assigns the equivalent string to the str_value member
; //also returns a pointer to the string
; char *incvar (struct menu_var *var)
; {
	.dbline 450
; 	getvalue(var, String_Var_ptr - 1);  //String_Var_ptr points to the char within var->str_value that is being modified
	ldab _String_Var_ptr
	tfr B,Y
	dey
	tfr Y,D
	clra
	std 0,S
	ldd 2,S
	xcall $_getvalue
	leas 4,S
	.dbline 452
; 					 			        //the enum value is retrieved and put in var->value so "incvar" and "decvar" can use it
;     IncSpeedUpTimer = MenuTimer * 1.1;
	movw #52429,2,-S
	movw #16268,2,-S
	ldd _MenuTimer
	jsr uint2fp
	jsr mulf4
	jsr fp2int
	tfr D,Y
	sty _IncSpeedUpTimer
	.dbline 454
;     
;     if (fast_inc)
	ldab _fast_inc
	cmpb #0
	beq L129
	.dbline 455
;         var->value = var->value + var->inc * 10;
	ldy 2,S
	ldx 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	movw #0,2,-S
	movw #16672,2,-S
	ldd 10,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr addf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	lbra L130
L129:
	.dbline 457
; 	else
; 	{
	.dbline 458
;         var->value = var->value + var->inc;
	ldy 2,S
	ldx 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 6,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr addf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 460
; 		
; 		if(var->value > var->max)
	ldy 2,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 6,S
	addd #12
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr cmpf4
	ble L131
	.dbline 461
;                var->value = var->min;   
	ldd 2,S
	addd #8
	tfr D,X
	ldy 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L131:
	.dbline 462
; 	}
L130:
	.dbline 464
; 		
;     if(var->value > var->max + var->inc / 10)
	ldy 2,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 6,S
	addd #12
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 10,S
	addd #4
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	movw #0,2,-S
	movw #16672,2,-S
	jsr divf4
	jsr addf4
	jsr cmpf4
	ble L133
	.dbline 465
;         var->value = var->min;
	ldd 2,S
	addd #8
	tfr D,X
	ldy 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L133:
	.dbline 467
; 	
;     return getstrval(var);
	ldd 2,S
	xcall $_getstrval
	.dbline -2
L128:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l var 2 pS[menu_var]
	.dbend
	.dbfunc e DecVariable _DecVariable fV
$_DecVariable::
	leas -2,S
	.dbline -1
	.dbline 471
; }
; 
; void DecVariable ( void )
; {
	.dbline 472
; 	 decvar(getVariable());
	xcall $_getVariable
	xcall $_decvar
	.dbline 473
;      LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 474
;      DisplayTitler ();
	xcall $_DisplayTitler
	.dbline -2
L135:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbend
	.dbfunc e decvar _decvar fpc
;            var -> 2,SP
$_decvar::
	pshd
	leas -2,S
	.dbline -1
	.dbline 482
; }
; 
; //Decrements a variable using the inc member
; //Wraps around to max value if min value is exceeded
; //assigns the equivalent string to the str_value member
; //also returns a pointer to the string
; char *decvar ( struct menu_var *var )
; {
	.dbline 483
;  	getvalue(var,String_Var_ptr-1);  // String_Var_ptr points to the char with in var>str_value that is being modified
	ldab _String_Var_ptr
	tfr B,Y
	dey
	tfr Y,D
	clra
	std 0,S
	ldd 2,S
	xcall $_getvalue
	leas 4,S
	.dbline 486
; 					 			   // the enum value is retrieved and put in var->value so "incvar" and "decvar" can use it
; 
;     IncSpeedUpTimer = MenuTimer * 1.1;
	movw #52429,2,-S
	movw #16268,2,-S
	ldd _MenuTimer
	jsr uint2fp
	jsr mulf4
	jsr fp2int
	tfr D,Y
	sty _IncSpeedUpTimer
	.dbline 488
;     
;     if ( fast_inc )
	ldab _fast_inc
	cmpb #0
	beq L137
	.dbline 489
;         var->value = var->value - var->inc*10;
	ldy 2,S
	ldx 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	movw #0,2,-S
	movw #16672,2,-S
	ldd 10,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr mulf4
	jsr subf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	lbra L138
L137:
	.dbline 491
; 	else
; 	{
	.dbline 492
;         var->value = var->value - var->inc;
	ldy 2,S
	ldx 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	ldd 6,S
	addd #4
	tfr D,X
	movw 2,X,2,-S
	movw 0,X,2,-S
	jsr subf4
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 494
; 		
; 		if(var->value < var->min)
	ldy 2,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 6,S
	addd #8
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	jsr cmpf4
	bge L139
	.dbline 495
; 		      var->value = var->max;
	ldd 2,S
	addd #12
	tfr D,X
	ldy 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L139:
	.dbline 496
; 	}	
L138:
	.dbline 498
; 		
;     if(var->value < var->min - var->inc / 10)
	ldy 2,S
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 6,S
	addd #8
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	ldd 10,S
	addd #4
	tfr D,Y
	movw 2,Y,2,-S
	movw 0,Y,2,-S
	movw #0,2,-S
	movw #16672,2,-S
	jsr divf4
	jsr subf4
	jsr cmpf4
	bge L141
	.dbline 499
;         var->value=var->max;
	ldd 2,S
	addd #12
	tfr D,X
	ldy 2,S
	movw 2,X,2,-S
	movw 0,X,2,-S
	pulx
	stx 0,Y
	pulx
	stx 2,Y
L141:
	.dbline 501
;     
;     return getstrval(var);
	ldd 2,S
	xcall $_getstrval
	.dbline -2
L136:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l var 2 pS[menu_var]
	.dbend
	.dbfunc e Select _Select fV
;              k -> 47,SP
$_Select::
	leas -49,S
	.dbline -1
	.dbline 506
; }
; 
; 
; void Select ( void )
; {
	.dbline 510
;      int k;
;      
;      //Save current menu pointers
;      MenuStackc[StackPointer+1].Index[0]=MenuStackc[StackPointer].Index[1];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 42,S
	ldy #_MenuStackc+1
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 46,S
	ldd 42,S
	ldx #_MenuStackc+6
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 46,S
	stab 0,Y
	.dbline 511
;      MenuStackc[StackPointer+1].Index[1]=MenuStackc[StackPointer].Index[2];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 40,S
	ldy #_MenuStackc+2
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 45,S
	ldd 40,S
	ldx #_MenuStackc+6+1
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 45,S
	stab 0,Y
	.dbline 512
;      MenuStackc[StackPointer+1].Index[2]=MenuStackc[StackPointer].Index[3];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 38,S
	ldy #_MenuStackc+3
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 44,S
	ldd 38,S
	ldx #_MenuStackc+6+2
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 44,S
	stab 0,Y
	.dbline 513
;      MenuStackc[StackPointer+1].Index[3] = MenuStackc[StackPointer].CursorPos + MenuStackc[StackPointer].FirstLine;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 36,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	std 34,S
	ldd 36,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 34,S
	tfr Y,B
	addb 0,X
	tfr B,Y
	sty 32,S
	ldd 36,S
	ldx #_MenuStackc+6+3
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 32,S
	stab 0,Y
	.dbline 516
;      
;      //look for selected menu 
;      for ( k=0;k<MenuSize;k++ )
	leax 47,S
	movw #0,0,x
L156:
	.dbline 517
;      {
	.dbline 518
;         if ( Menuc[k].Index[0] == MenuStackc[StackPointer+1].Index[0] && Menuc[k].Index[1] == MenuStackc[StackPointer+1].Index[1] && 
	ldd #311
	ldy 47,S
	emul
	tfr D,Y
	ldx #6
	sty 30,S
	ldab _StackPointer
	clra
	tfr D,Y
	tfr X,D
	emul
	std 28,S
	ldy #_MenuStackc+6
	sty 0,S
	addd 0,S
	std 26,S
	ldd 30,S
	ldx #_Menuc
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 26,S
	tfr Y,B
	cmpb 0,X
	lbne L160
	ldd 28,S
	ldy #_MenuStackc+6+1
	sty 0,S
	addd 0,S
	std 24,S
	ldd 30,S
	ldx #_Menuc+1
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 24,S
	tfr Y,B
	cmpb 0,X
	lbne L160
	ldd 28,S
	ldy #_MenuStackc+6+2
	sty 0,S
	addd 0,S
	std 22,S
	ldd 30,S
	ldx #_Menuc+2
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 22,S
	tfr Y,B
	cmpb 0,X
	lbne L160
	ldd 28,S
	ldy #_MenuStackc+6+3
	sty 0,S
	addd 0,S
	std 20,S
	ldd 30,S
	ldx #_Menuc+3
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 20,S
	tfr Y,B
	cmpb 0,X
	bne L160
	.dbline 520
;              Menuc[k].Index[2] == MenuStackc[StackPointer+1].Index[2] && Menuc[k].Index[3] == MenuStackc[StackPointer+1].Index[3] )
;         {
	.dbline 522
;              //If found increment stackpointer and initialize cursor
;              StackPointer++;
	inc _StackPointer
	.dbline 524
;              //Cursor to menu entry 1
;              MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 525
;              MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 526
;              LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 527
;              InsertCursor ();
	xcall $_InsertCursor
	.dbline 528
;              DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 529
;              break;
	bra L158
L160:
	.dbline 531
;         }
;      } 
L157:
	.dbline 516
	ldy 47,S
	iny
	sty 47,S
	.dbline 516
	cpy #6
	lblt L156
L158:
	.dbline 533
; 
;      if ( k >= MenuSize )
	ldy 47,S
	cpy #6
	lblt L174
	.dbline 534
;      {
	.dbline 536
;          //Find out which menu we are on
;          for ( k=0;k<MenuSize;k++ )
	leax 47,S
	movw #0,0,x
L176:
	.dbline 537
;          {
	.dbline 538
;             if ( Menuc[k].Index[0] == MenuStackc[StackPointer].Index[0] && Menuc[k].Index[1] == MenuStackc[StackPointer].Index[1] && 
	ldd #311
	ldy 47,S
	emul
	tfr D,Y
	ldx #6
	sty 18,S
	ldab _StackPointer
	clra
	tfr D,Y
	tfr X,D
	emul
	std 16,S
	ldy #_MenuStackc
	sty 0,S
	addd 0,S
	std 14,S
	ldd 18,S
	ldx #_Menuc
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 14,S
	tfr Y,B
	cmpb 0,X
	lbne L180
	ldd 16,S
	ldy #_MenuStackc+1
	sty 0,S
	addd 0,S
	std 12,S
	ldd 18,S
	ldx #_Menuc+1
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 12,S
	tfr Y,B
	cmpb 0,X
	lbne L180
	ldd 16,S
	ldy #_MenuStackc+2
	sty 0,S
	addd 0,S
	std 10,S
	ldd 18,S
	ldx #_Menuc+2
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 10,S
	tfr Y,B
	cmpb 0,X
	lbne L180
	ldd 16,S
	ldy #_MenuStackc+3
	sty 0,S
	addd 0,S
	std 8,S
	ldd 18,S
	ldx #_Menuc+3
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 8,S
	tfr Y,B
	cmpb 0,X
	lbne L180
	.dbline 540
;                  Menuc[k].Index[2] == MenuStackc[StackPointer].Index[2] && Menuc[k].Index[3] == MenuStackc[StackPointer].Index[3] )
;             {
	.dbline 542
;                  //Execute function for that entry 
;                  Menuc[k].FunctPtr[(MenuStackc[StackPointer].CursorPos + MenuStackc[StackPointer].FirstLine)-1]();
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 6,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 4,S
	ldd 6,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 4,S
	tfr Y,D
	stx 0,S
	addd 0,S
	subd #1
	lsld
	std 2,S
	ldy 47,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+289
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldy 0,Y
	jsr 0,Y
	.dbline 543
;                  break;
	bra L178
L180:
	.dbline 545
;             }
;         }
L177:
	.dbline 536
	ldy 47,S
	iny
	sty 47,S
	.dbline 536
	cpy #6
	lblt L176
L178:
	.dbline 546
;    }
L174:
	.dbline -2
L143:
	.dbline 0 ; func end
	leas 49,S
	rtc
	.dbsym l k 47 I
	.dbend
	.dbfunc e DeSelect _DeSelect fV
;      hexNodeID -> 2,SP
;              i -> 4,SP
;              j -> 6,SP
$_DeSelect::
	leas -8,S
	.dbline -1
	.dbline 550
; }
; 
; void DeSelect ( void )
; {
	.dbline 554
;      int i,j;
; 	 short hexNodeID;
; 	 
;      if (StackPointer )
	ldab _StackPointer
	cmpb #0
	beq L192
	.dbline 555
;      {
	.dbline 556
;         StackPointer--;
	dec _StackPointer
	.dbline 557
;         LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	xcall $_LoadMenu
	.dbline 558
;         InsertCursor ();
	xcall $_InsertCursor
	.dbline 559
;         DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 560
;      }
	lbra L193
L192:
	.dbline 562
;      else
;      {
	.dbline 563
;         MenuStackc[StackPointer].Index[0] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 564
;         MenuStackc[StackPointer].Index[1] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+1
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 565
;         MenuStackc[StackPointer].Index[2] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+2
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 566
;         MenuStackc[StackPointer].Index[3] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 567
;         Gen_Flags &= ~Gen_Flags_Menu_Active;
	bclr _Gen_Flags,#1
	.dbline 568
; 		ClearTitler ();
	xcall $_ClearTitler
	.dbline 569
;         Timer1 = RTI_One_Sec * 0.05;
	movw #48,_Timer1
L197:
	.dbline 570
; 	    while ( Timer1 );
L198:
	.dbline 570
	ldy _Timer1
	cpy #0
	bne L197
	.dbline 571
;         Send_Menu_Status(0x00);
	ldd #0
	xcall $_Send_Menu_Status
	.dbline 572
; 		for (j=1;j<=NR_OF_TPDOS;j++)
	movw #1,6,S
L200:
	.dbline 573
; 		{
	.dbline 574
; 		    COP_Trig();
	xcall $_COP_Trig
	.dbline 575
; 			i = MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	clra
	std 4,S
	.dbline 576
; 		}
L201:
	.dbline 572
	ldy 6,S
	iny
	sty 6,S
	.dbline 572
	cpy #8
	ble L200
	.dbline 577
; 		StoreFlag = 1;
	movb #1,_StoreFlag
	.dbline 581
; 		//Save_Serial_Num();               //This has to be called before 'Save_Variables', otherwise EEPROM may not be available to read right away
;         //Save_Variables();
; 
;      }
L193:
	.dbline 582
; 	 Variable_flag = 0;
	clr _Variable_flag
	.dbline 583
; 	 String_Var_ptr = 0;
	clr _String_Var_ptr
	.dbline 584
; 	 Multi_Var_ptr = 0;
	clr _Multi_Var_ptr
	.dbline 585
; 	 UpdateArrayVar = 0;
	clr _UpdateArrayVar
	.dbline -2
L191:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbsym l hexNodeID 2 S
	.dbsym l i 4 I
	.dbsym l j 6 I
	.dbend
	.dbfunc e LoadMenu _LoadMenu fV
;              l -> 46,SP
;      next_flag -> 48,SP
;       var_cntr -> 49,SP
;            var -> 51,SP
;              l -> 53,SP
;              k -> 55,SP
;              j -> 57,SP
;              i -> 59,SP
;          Index -> 61,SP
$_LoadMenu::
	pshd
	leas -61,S
	.dbline -1
	.dbline 591
; }
; 
; 
; 
; void LoadMenu ( char Index[] )
; {
	.dbline 595
;     int i,j,k,l;
; 
;     //find menu
; 	k = FindMenu();
	xcall $_FindMenu
	clra
	std 55,S
	.dbline 598
; 	
;     //Get Menu Title
;     for ( j=0;j<=20;j++ )
	leax 57,S
	movw #0,0,x
L205:
	.dbline 599
; 	{
	.dbline 600
;         Menu[0][j] = Menuc[k].Entry[0][j];
	ldd #311
	ldy 55,S
	emul
	tfr D,Y
	ldx #_Menuc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 57,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 52,S
	ldd 57,S
	ldx #_Menu
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 52,S
	stab 0,Y
	.dbline 601
; 	}
L206:
	.dbline 598
	ldy 57,S
	iny
	sty 57,S
	.dbline 598
	cpy #20
	ble L205
	.dbline 604
;        
;     //See if this entry is a valid menu entry, if not start cursor back at top
;     if ( MenuStackc[StackPointer].CursorPos > 0 && Menuc[k].Entry[MenuStackc[StackPointer].CursorPos + MenuStackc[StackPointer].FirstLine][1] == ' ' )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 44,S
	ldy #_MenuStackc+4
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbls L210
	ldd 44,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	std 42,S
	ldd 44,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldx 42,S
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #21
	emul
	std 40,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 40,S
	sty 0,S
	addd 0,S
	tfr D,Y
	iny
	ldab 0,Y
	cmpb #32
	bne L210
	.dbline 605
;     {
	.dbline 606
;          MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 607
;          MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 608
;     }
L210:
	.dbline 611
;         
;     //Allow a maximum of 12 entries, if past 12, start cursor back at top
;     if ( MenuStackc[StackPointer].CursorPos + MenuStackc[StackPointer].FirstLine >= 12 )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	std 38,S
	ldy #_MenuStackc+5
	sty 0,S
	addd 0,S
	std 36,S
	ldd 38,S
	ldx #_MenuStackc+4
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 36,S
	tfr Y,B
	addb 0,X
	cmpb #12
	blo L218
	.dbline 612
;     {
	.dbline 613
;          MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 614
;          MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 615
;     }
L218:
	.dbline 618
;         
;     //If cursor is too far down, check to see if there is another entry, if so, show it and set cursor to bottom entry.
;     if ( MenuStackc[StackPointer].CursorPos == 9 )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #9
	lbne L224
	.dbline 619
;     {
	.dbline 620
;          if ( Menuc[k].Entry[9+MenuStackc[StackPointer].FirstLine][1] != ' ' )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd #21
	emul
	addd #189
	std 34,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 34,S
	sty 0,S
	addd 0,S
	tfr D,Y
	iny
	ldab 0,Y
	cmpb #32
	beq L227
	.dbline 621
;          {
	.dbline 622
;             MenuStackc[StackPointer].FirstLine++;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	sty 32,S
	ldab [32,S]
	tfr B,Y
	iny
	ldx 32,S
	tfr Y,B
	stab 0,X
	.dbline 623
;             MenuStackc[StackPointer].CursorPos = 8;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #8
	stab 0,Y
	.dbline 624
;          }
	bra L228
L227:
	.dbline 626
;          else
;          {
	.dbline 627
;              MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 628
;              MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 629
;          }
L228:
	.dbline 630
;     }
L224:
	.dbline 633
; 
;     //If cursor is too far up, and the first entry is not the first line then move firstline up and set cursor to top entry
;     if ( MenuStackc[StackPointer].CursorPos == 0 )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbne L235
	.dbline 634
;     {
	.dbline 635
;          if ( MenuStackc[StackPointer].FirstLine )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	beq L238
	.dbline 636
;          {
	.dbline 637
;             MenuStackc[StackPointer].FirstLine--;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	sty 30,S
	ldab [30,S]
	tfr B,Y
	dey
	ldx 30,S
	tfr Y,B
	stab 0,X
	.dbline 638
;             MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 639
;          }
	lbra L239
L238:
	.dbline 641
;          else
;          {
	.dbline 643
;              //Find last entry
;              for ( i=11;i>0;i-- )
	leax 59,S
	movw #11,0,x
L243:
	.dbline 644
;              {
	.dbline 645
;                  if ( Menuc[k].Entry[i][1] != ' ' && Menuc[k].Entry[i][0] == ' ' )
	ldd #21
	ldy 59,S
	emul
	tfr D,Y
	ldx #311
	sty 28,S
	ldy 55,S
	tfr X,D
	emul
	std 26,S
	ldy #_Menuc+4
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 28,S
	sty 0,S
	addd 0,S
	tfr D,Y
	iny
	ldab 0,Y
	cmpb #32
	beq L247
	ldd 26,S
	ldy #_Menuc+4
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 28,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #32
	bne L247
	.dbline 646
;                       break;
	bra L245
L247:
	.dbline 647
;              }
L244:
	.dbline 643
	ldy 59,S
	dey
	sty 59,S
	.dbline 643
	cpy #0
	bgt L243
L245:
	.dbline 649
;              //If more than 8 entries, cursor will be at the bottom (8) and first line will be adjusted
;              if ( i > 8 )
	ldy 59,S
	cpy #8
	ble L251
	.dbline 650
;              {
	.dbline 651
;                  MenuStackc[StackPointer].CursorPos = 8;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #8
	stab 0,Y
	.dbline 652
;                  MenuStackc[StackPointer].FirstLine = i - 8;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 59,S
	subd #8
	clra
	stab 0,Y
	.dbline 653
;              }
	bra L252
L251:
	.dbline 656
;              //Otherwise the cursor will be on that entry with the firstline at 0
;              else
;              {
	.dbline 657
;                  MenuStackc[StackPointer].CursorPos = i;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 59,S
	clra
	stab 0,Y
	.dbline 658
;                  MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 659
;              }
L252:
	.dbline 660
;          }
L239:
	.dbline 661
;     }
L235:
	.dbline 664
; 
;     //Load appropriate menu entries into Menu[i][j]
;     for ( i=1;i<=8;i++ )
	leax 59,S
	movw #1,0,x
L257:
	.dbline 665
; 	{
	.dbline 666
; 	    for ( j=0;j<=20;j++ )
	leax 57,S
	movw #0,0,x
L261:
	.dbline 667
; 		{
	.dbline 668
;             Menu[i][j] = Menuc[k].Entry[i+MenuStackc[StackPointer].FirstLine][j];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #21
	emul
	std 24,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 24,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 57,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 52,S
	ldy 59,S
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 57,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 52,S
	stab 0,Y
	.dbline 669
; 		}
L262:
	.dbline 666
	ldy 57,S
	iny
	sty 57,S
	.dbline 666
	cpy #20
	lble L261
	.dbline 670
; 	}
L258:
	.dbline 664
	ldy 59,S
	iny
	sty 59,S
	.dbline 664
	cpy #8
	lble L257
	.dbline 673
; 	
; 	//Load any variables
;     for ( i=1;i<=8;i++ )
	leax 59,S
	movw #1,0,x
L267:
	.dbline 674
; 	{
	.dbline 675
;         if ( Menuc[k].Pos[i+MenuStackc[StackPointer].FirstLine-1] )
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	dey
	sty 22,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+256
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 22,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbeq L271
	.dbline 676
;         {
	.dbline 677
; 			 struct menu_var *var = Menuc[k].VarPntr[i+MenuStackc[StackPointer].FirstLine-1];
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	subd #1
	lsld
	std 20,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+267
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 20,S
	sty 0,S
	addd 0,S
	tfr D,Y
	leax 51,S
	movw 0,Y,0,x
	.dbline 678
; 			 char next_flag = 1;
	leax 48,S
	movb #1,0,x
	.dbline 679
; 			 int var_cntr = 1;
	leax 49,S
	movw #1,0,x
	.dbline 681
; 			 
;              j=0;    
	leax 57,S
	movw #0,0,x
L277:
	.dbline 683
; 			 do 
; 			 {	  
	.dbline 685
;                  int l;
; 				 for (l=0;j<=20;j++,l++ )//up to 11 char variable "STR_VALUE_LEN"
	leax 46,S
	movw #0,0,x
	lbra L283
L280:
	.dbline 686
;                  {
	.dbline 688
;     				 
;                     if ( !Multi_Var_ptr && Variable_flag && i == MenuStackc[StackPointer].CursorPos && l==0 ) 
	ldab _Multi_Var_ptr
	cmpb #0
	lbne L284
	ldab _Variable_flag
	cmpb #0
	lbeq L284
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	cpd 59,S
	lbne L284
	ldy 46,S
	cpy #0
	lbne L284
	.dbline 689
;                         Menu[i][Menuc[k].Pos[i+MenuStackc[StackPointer].FirstLine-1]-1] = '>';
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	dey
	sty 18,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+256
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 18,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	dey
	sty 16,S
	ldy 59,S
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 16,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #62
	stab 0,Y
L284:
	.dbline 691
; 
;                     if ( Multi_Var_ptr == var_cntr && i == MenuStackc[StackPointer].CursorPos && l==0 )
	ldab _Multi_Var_ptr
	clra
	cpd 49,S
	lbne L289
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	cpd 59,S
	lbne L289
	ldy 46,S
	cpy #0
	lbne L289
	.dbline 692
; 					{
	.dbline 693
; 						 Menu[i][Menuc[k].Pos[i+MenuStackc[StackPointer].FirstLine-1]+j-1] = '>';
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	dey
	sty 14,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+256
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 14,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	addd 57,S
	tfr D,Y
	dey
	sty 12,S
	ldy 59,S
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 12,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #62
	stab 0,Y
	.dbline 694
; 					}
L289:
	.dbline 696
;                     
;     				if ( var->len_str >= 0 )
	ldd 51,S
	addd #17
	tfr D,Y
	ldab 0,Y
	cmpb #0
	blt L294
	.dbline 697
;     				{    
	.dbline 698
;     				     getstrval ( var );
	ldd 51,S
	xcall $_getstrval
	.dbline 699
;     			    }
L294:
	.dbline 701
; 					
;     				if ( *(var->str_value+l) ) //if current char of string isn't a NULL
	ldd 51,S
	addd #18
	tfr D,Y
	ldd 46,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	lbeq L282
	.dbline 702
;                     {
	.dbline 703
;                          Menu[i][Menuc[k].Pos[i+MenuStackc[StackPointer].FirstLine-1]+j] = *(var->str_value+l);
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	dey
	sty 10,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+256
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 10,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	addd 57,S
	std 8,S
	ldy 59,S
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 8,S
	sty 0,S
	addd 0,S
	tfr D,Y
	sty 6,S
	ldd 51,S
	addd #18
	tfr D,X
	ldd 46,S
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 6,S
	tfr Y,B
	stab 0,X
	.dbline 704
;                     }
	.dbline 706
;                     else
;                     {
	.dbline 707
;                         break;
L297:
	.dbline 709
;                     }
;                  }
L281:
	.dbline 685
	ldy 57,S
	iny
	sty 57,S
	ldy 46,S
	iny
	sty 46,S
L283:
	.dbline 685
	ldy 57,S
	cpy #20
	lble L280
L282:
	.dbline 710
; 				 if (var->next_var)
	ldd 51,S
	addd #32
	tfr D,Y
	ldy 0,Y
	cpy #0
	lbeq L300
	.dbline 711
; 				 {
	.dbline 712
; 					 var = var->next_var;
	ldy 51,S
	leay 32,Y
	leax 51,S
	movw 0,y,0,x
	.dbline 713
; 					 Menu[i][Menuc[k].Pos[i+MenuStackc[StackPointer].FirstLine-1]+j] = ' ';
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd 59,S
	sty 0,S
	addd 0,S
	tfr D,Y
	dey
	sty 4,S
	ldy 55,S
	ldd #311
	emul
	tfr D,Y
	ldx #_Menuc+256
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 4,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	addd 57,S
	std 2,S
	ldy 59,S
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #32
	stab 0,Y
	.dbline 714
; 					 j++;
	ldy 57,S
	iny
	sty 57,S
	.dbline 715
; 				  	 var_cntr++;
	ldy 49,S
	iny
	sty 49,S
	.dbline 716
; 				 }
	bra L301
L300:
	.dbline 718
; 				 else
; 				 {
	.dbline 719
; 				     next_flag = 0;
	clr 48,S
	.dbline 720
; 				 }
L301:
	.dbline 721
; 			 }while(next_flag);
L278:
	.dbline 721
	ldab 48,S
	cmpb #0
	lbne L277
	.dbline 722
;         }            
L271:
	.dbline 723
; 	}
L268:
	.dbline 673
	ldy 59,S
	iny
	sty 59,S
	.dbline 673
	cpy #8
	lble L267
	.dbline -2
L204:
	.dbline 0 ; func end
	leas 63,S
	rtc
	.dbsym l l 46 I
	.dbsym l next_flag 48 c
	.dbsym l var_cntr 49 I
	.dbsym l var 51 pS[menu_var]
	.dbsym l l 53 I
	.dbsym l k 55 I
	.dbsym l j 57 I
	.dbsym l i 59 I
	.dbsym l Index 61 pc
	.dbend
	.dbfunc e InsertCursor _InsertCursor fV
$_InsertCursor::
	leas -2,S
	.dbline -1
	.dbline 727
; }
; 
; void InsertCursor ( void )
; {
	.dbline 729
; 	//Display Cursor Pointer
;     Menu[MenuStackc[StackPointer].CursorPos][0] = '>';
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	clra
	tfr D,Y
	ldd #21
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd #62
	stab 0,Y
	.dbline -2
L304:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbend
	.dbfunc e DisplayTitler _DisplayTitler fV
;              l -> 3,SP
;              i -> 5,SP
;              j -> 7,SP
;              k -> 9,SP
$_DisplayTitler::
	leas -11,S
	.dbline -1
	.dbline 736
; }     
; 
; #define Disp_Wait_Time1  0.001
; #define Disp_Wait_Time2  0.005
; 
; void DisplayTitler ( void )
; {
	.dbline 739
; 	int i,j,k,l;
; 	
;     PositionDisplay ();
	xcall $_PositionDisplay
	.dbline 741
; 	
; 	gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 742
; 	gTxMsg.LEN = 8;
	movb #8,_gTxMsg+2
	.dbline 743
; 	gTxMsg.BUF[0] = 0;
	clr _gTxMsg+4
	.dbline 744
; 	gTxMsg.BUF[1] = 0x02;
	movb #2,_gTxMsg+4+1
	.dbline 745
; 	gTxMsg.BUF[2] = 'M';
	movb #77,_gTxMsg+4+2
	.dbline 746
; 	gTxMsg.BUF[3] = 'e';
	movb #101,_gTxMsg+4+3
	.dbline 747
; 	gTxMsg.BUF[4] = 'n';
	movb #110,_gTxMsg+4+4
	.dbline 748
; 	gTxMsg.BUF[5] = 'u';
	movb #117,_gTxMsg+4+5
	.dbline 749
; 	gTxMsg.BUF[6] = ':';
	movb #58,_gTxMsg+4+6
	.dbline 750
; 	gTxMsg.BUF[7] = 0;
	clr _gTxMsg+4+7
	.dbline 752
; 	
;    	if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L323
	.dbline 753
;    	{
	.dbline 755
;         // failed to transmit
;        	MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 756
;     }
L323:
	.dbline 757
; 	Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L325:
	.dbline 758
; 	while ( Timer1 );
L326:
	.dbline 758
	ldy _Timer1
	cpy #0
	bne L325
	.dbline 760
; 	
; 	for ( i=0;i<=8;i++ )        //9 lines
	movw #0,5,S
L328:
	.dbline 761
; 	{
	.dbline 762
; 	    gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 763
; 		gTxMsg.LEN = 7;
	movb #7,_gTxMsg+2
	.dbline 764
; 		gTxMsg.BUF[0] = 0;
	clr _gTxMsg+4
	.dbline 765
; 		gTxMsg.BUF[6] = 0;
	clr _gTxMsg+4+6
	.dbline 766
; 	    for ( j=0;j<=15;j+=5 )
	movw #0,7,S
L336:
	.dbline 767
; 		{
	.dbline 768
;     	    COP_Trig();
	xcall $_COP_Trig
	.dbline 769
; 		 	for ( k=0;k<=4;k++ )
	movw #0,9,S
L340:
	.dbline 770
; 			{
	.dbline 771
; 		     	gTxMsg.BUF[k+1] = Menu[i][j+k];
	ldd #21
	ldy 5,S
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 0,S
	addd 0,S
	tfr D,Y
	ldd 7,S
	addd 9,S
	sty 0,S
	addd 0,S
	tfr D,Y
	ldab 0,Y
	stab 2,S
	ldd 9,S
	ldx #_gTxMsg+4+1
	stx 0,S
	addd 0,S
	tfr D,Y
	ldab 2,S
	stab 0,Y
	.dbline 772
; 			}
L341:
	.dbline 769
	ldy 9,S
	iny
	sty 9,S
	.dbline 769
	cpy #4
	ble L340
	.dbline 773
;    	    	if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L346
	.dbline 774
;    			{
	.dbline 776
;                 // failed to transmit
;        			MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 777
;     		}
L346:
	.dbline 778
; 			Timer1 = RTI_One_Sec * Disp_Wait_Time2;
	movw #4,_Timer1
L348:
	.dbline 779
; 			while ( Timer1 );
L349:
	.dbline 779
	ldy _Timer1
	cpy #0
	bne L348
	.dbline 780
; 			l = MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	clra
	std 3,S
	.dbline 781
; 		}
L337:
	.dbline 766
	ldd 7,S
	addd #5
	std 7,S
	.dbline 766
	cpd #15
	lble L336
	.dbline 782
; 		MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	.dbline 783
; 	}
L329:
	.dbline 760
	ldy 5,S
	iny
	sty 5,S
	.dbline 760
	cpy #8
	lble L328
	.dbline 786
; 
; 
; 	gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 787
; 	gTxMsg.LEN = 3;
	movb #3,_gTxMsg+2
	.dbline 788
; 	gTxMsg.BUF[0] = 0;
	clr _gTxMsg+4
	.dbline 789
; 	gTxMsg.BUF[1] = 0x03;
	movb #3,_gTxMsg+4+1
	.dbline 790
; 	gTxMsg.BUF[2] = 0;
	clr _gTxMsg+4+2
	.dbline 792
; 
;    	if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L357
	.dbline 793
;    	{
	.dbline 795
;         // failed to transmit
;        	MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 796
;     }
L357:
	.dbline 797
; 	Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L359:
	.dbline 798
; 	while ( Timer1 );
L360:
	.dbline 798
	ldy _Timer1
	cpy #0
	bne L359
	.dbline -2
L306:
	.dbline 0 ; func end
	leas 11,S
	rtc
	.dbsym l l 3 I
	.dbsym l i 5 I
	.dbsym l j 7 I
	.dbsym l k 9 I
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
L363:
	.blkb 2
L364:
	.blkb 2
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e Display _Display fV
	.dbsym s j L364 I
	.dbsym s i L363 I
;           buff -> 4,SP
$_Display::
	pshd
	leas -4,S
	.dbline -1
	.dbline 803
; 
; }
; 
; void Display(char buff[27])
; {
	.dbline 806
;     static int i,j;
;     
;     gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 807
;     gTxMsg.LEN = 8;
	movb #8,_gTxMsg+2
	.dbline 808
;     gTxMsg.BUF[0] = NODE_ID; //not sent
	movb #33,_gTxMsg+4
	.dbline 809
;     gTxMsg.BUF[1] = 0x02; //starting w/ Rev 2.0, <STX> indicates beginning of command
	movb #2,_gTxMsg+4+1
	.dbline 811
;     
;     for (i=0; i<=5; i++)
	movw #0,L363
L369:
	.dbline 812
;     {
	.dbline 813
;         gTxMsg.BUF[i+2] = buff[i];
	ldd L363
	ldy #_gTxMsg+4+2
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd L363
	addd 4,S
	tfr D,X
	ldab 0,X
	stab 0,Y
	.dbline 814
;     }
L370:
	.dbline 811
	ldy L363
	iny
	sty L363
	.dbline 811
	ldy L363
	cpy #5
	ble L369
	.dbline 816
;     
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L375
	.dbline 817
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
L375:
	.dbline 819
;     
;     Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L377:
	.dbline 820
;     while ( Timer1 );
L378:
	.dbline 820
	ldy _Timer1
	cpy #0
	bne L377
	.dbline 822
;     
;     gTxMsg.BUF[0] = NODE_ID; 
	movb #33,_gTxMsg+4
	.dbline 824
;     
;     for (i=6; i<strlen(buff); i+=7)
	movw #6,L363
	bra L384
L381:
	.dbline 825
;     {
	.dbline 826
;         if (i >= 27)
	ldy L363
	cpy #27
	blt L385
	.dbline 827
;             break;
	lbra L383
L385:
	.dbline 829
;         
;         for (j=0; j<=6; j++)
	movw #0,L364
L387:
	.dbline 830
;         {
	.dbline 831
;             gTxMsg.BUF[j+1] = buff[i+j]; //6-12; 13-19; 14-20
	ldd L364
	ldy #_gTxMsg+4+1
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd L363
	addd L364
	addd 4,S
	tfr D,X
	ldab 0,X
	stab 0,Y
	.dbline 832
;         }
L388:
	.dbline 829
	ldy L364
	iny
	sty L364
	.dbline 829
	ldy L364
	cpy #6
	ble L387
	.dbline 834
;         
;         if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L393
	.dbline 835
;             MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
L393:
	.dbline 837
;         
;         Timer1 = RTI_One_Sec * Disp_Wait_Time2;
	movw #4,_Timer1
L395:
	.dbline 838
;         while ( Timer1 );
L396:
	.dbline 838
	ldy _Timer1
	cpy #0
	bne L395
	.dbline 840
;         
;         MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	.dbline 841
;     }
L382:
	.dbline 824
	ldd L363
	addd #7
	std L363
L384:
	.dbline 824
	ldd 4,S
	xcall $_strlen
	std 2,S
	ldy L363
	cpy 2,S
	lblo L381
L383:
	.dbline 843
;     
;     gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 844
;     gTxMsg.LEN = 3;
	movb #3,_gTxMsg+2
	.dbline 845
;     gTxMsg.BUF[0] = NODE_ID;
	movb #33,_gTxMsg+4
	.dbline 846
;     gTxMsg.BUF[1] = 0x03;
	movb #3,_gTxMsg+4+1
	.dbline 847
;     gTxMsg.BUF[2] = 0;
	clr _gTxMsg+4+2
	.dbline 849
;     
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L404
	.dbline 850
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
L404:
	.dbline 852
;     
;     Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L406:
	.dbline 853
;     while ( Timer1 );
L407:
	.dbline 853
	ldy _Timer1
	cpy #0
	bne L406
	.dbline -2
L362:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l buff 4 pc
	.dbend
	.dbfunc e PositionDisplay _PositionDisplay fV
$_PositionDisplay::
	.dbline -1
	.dbline 858
;     
; }
; 
; void PositionDisplay ( void )
; {
	.dbline 859
; 	gTxMsg.ID = WTX_ID;
	movw #784,_gTxMsg
	.dbline 860
; 	gTxMsg.LEN = 8;
	movb #8,_gTxMsg+2
	.dbline 861
; 	gTxMsg.BUF[0] = 0;
	clr _gTxMsg+4
	.dbline 862
; 	gTxMsg.BUF[1] = 0x02;
	movb #2,_gTxMsg+4+1
	.dbline 863
; 	gTxMsg.BUF[2] = 'H';
	movb #72,_gTxMsg+4+2
	.dbline 864
; 	gTxMsg.BUF[3] = 'o';
	movb #111,_gTxMsg+4+3
	.dbline 865
; 	gTxMsg.BUF[4] = 'm';
	movb #109,_gTxMsg+4+4
	.dbline 866
; 	gTxMsg.BUF[5] = 'e';
	movb #101,_gTxMsg+4+5
	.dbline 867
; 	gTxMsg.BUF[6] = ':';
	movb #58,_gTxMsg+4+6
	.dbline 868
; 	gTxMsg.BUF[7] = 0x03;
	movb #3,_gTxMsg+4+7
	.dbline 870
; 	
;    	if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L426
	.dbline 871
;    	{
	.dbline 873
;         // failed to transmit
;        	MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 874
;     }
L426:
	.dbline 875
; 	Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L428:
	.dbline 876
; 	while ( Timer1 );
L429:
	.dbline 876
	ldy _Timer1
	cpy #0
	bne L428
	.dbline -2
L409:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e ClearTitler _ClearTitler fV
	.dbstruct 0 12 .2
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
;              i -> 0,SP
;         pTxMsg -> 2,SP
;         gTxMsg -> 4,SP
$_ClearTitler::
	leas -16,S
	.dbline -1
	.dbline 880
; }
; 
; void ClearTitler ( void )
; {
	.dbline 883
;     int i;
; 	CAN_MSG gTxMsg;
; 	CAN_MSG *pTxMsg = &gTxMsg;
	leay 4,S
	sty 2,S
	.dbline 885
; 
; 	gTxMsg.ID = WTX_ID;
	movw #784,4,S
	.dbline 886
; 	gTxMsg.LEN = 8;
	movb #8,6,S
	.dbline 887
; 	gTxMsg.BUF[0] = 0;
	clr 8,S
	.dbline 888
; 	gTxMsg.BUF[1] = 0x02;
	movb #2,9,S
	.dbline 889
; 	gTxMsg.BUF[2] = 'C';
	movb #67,10,S
	.dbline 890
; 	gTxMsg.BUF[3] = 'l';
	movb #108,11,S
	.dbline 891
; 	gTxMsg.BUF[4] = 'r';
	movb #114,12,S
	.dbline 892
; 	gTxMsg.BUF[5] = ':';
	movb #58,13,S
	.dbline 893
; 	gTxMsg.BUF[6] = 0x03;
	movb #3,14,S
	.dbline 894
; 	gTxMsg.BUF[7] = 0;       //place-holder character, RF will not transmit null
	clr 15,S
	.dbline 897
; 
; 	
; 	if (!MCOHW_PushMessage(&gTxMsg))
	leay 4,S
	tfr Y,D
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L448
	.dbline 898
;    	{
	.dbline 900
;         // failed to transmit
;        	MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 901
;     }
L448:
	.dbline 902
; 	Timer1 = RTI_One_Sec * Disp_Wait_Time1;
	movw #0,_Timer1
L450:
	.dbline 903
; 	while ( Timer1 );
L451:
	.dbline 903
	ldy _Timer1
	cpy #0
	bne L450
	.dbline -2
L431:
	.dbline 0 ; func end
	leas 16,S
	rtc
	.dbsym l i 0 I
	.dbsym l pTxMsg 2 pS[.2]
	.dbsym l gTxMsg 4 S[.2]
	.dbend
	.dbfunc e menu_function _menu_function fI
; CamAddressXmitd -> 10,SP
;              i -> 11,SP
$_menu_function::
	leas -13,S
	.dbline -1
	.dbline 909
; 
; }
; 
; 
; int menu_function (void)
; {
	.dbline 914
;     int i;
; 	
;     char CamAddressXmitd;
; 
;     if (State == FinishState)
	ldab _State
	cmpb #99
	bne L454
	.dbline 915
;         InProcess = 0;
	clr _InProcess
	bra L455
L454:
	.dbline 917
;     else
;         InProcess = 1;
	movb #1,_InProcess
L455:
	.dbline 919
; 
;     if ( StoreFlag && State == FinishState)
	ldab _StoreFlag
	cmpb #0
	beq L456
	ldab _State
	cmpb #99
	bne L456
	.dbline 920
;     {
	.dbline 921
;         StoreFlag = 0;
	clr _StoreFlag
	.dbline 923
;         //if detects CamTag is different, send msg to controller to update camera list
;         if (strncmp(&CamTag.str_value[0], &EE_CamTag[0], STR_VALUE_LEN - 1) != 0)
	ldy #11
	sty 2,S
	ldy #_EE_CamTag
	sty 0,S
	ldd #_CamTag+18
	xcall $_strncmp
	cpd #0
	beq L458
	.dbline 924
;         {
	.dbline 925
;             Update_Cam_List();        
	xcall $_Update_Cam_List
	.dbline 926
;         }
L458:
	.dbline 927
;         Save_Serial_Num(); //This has to be called before 'Save_Variables', otherwise EEPROM may not be available to read right away
	xcall $_Save_Serial_Num
	.dbline 928
;         Save_Variables();
	xcall $_Save_Variables
	.dbline 929
;     }
L456:
	.dbline 931
; 		
;     if ( TC0_RCVD_Data != ( gProcImg[OUT_digi_2]<<8 | gProcImg[OUT_digi_1] ) )
	ldab _gProcImg+25
	tfr B,D
	tfr B,A
	ldab _gProcImg+24
	cpd _TC0_RCVD_Data
	beq L461
	.dbline 932
;     {
	.dbline 933
;         TC0_RCVD_Data = gProcImg[OUT_digi_2]<<8 | gProcImg[OUT_digi_1];
	ldab _gProcImg+25
	tfr B,D
	tfr B,A
	ldab _gProcImg+24
	std _TC0_RCVD_Data
	.dbline 934
;     }
L461:
	.dbline 936
; 
;     if ( (gProcImg[OUT_digi_6] & 0x08) &&              //command to activate menu
	brclr _gProcImg+29,#8,X0
	bra X1
X0: lbra L467
X1:
	ldd _cam_add
	anda #0
	andb #-1
	tfr D,Y
	ldab _gProcImg+30
	clra
	tfr D,X
	sty 4,S
	cpx 4,S
	lbne L467
	ldd _cam_add
	anda #-1
	andb #0
	tfr D,Y
	clrb
	ldaa _gProcImg+31
	tfr D,X
	sty 4,S
	cpx 4,S
	lbne L467
	ldab _Gen_Flags
	bitb #1
	lbne L467
	.dbline 940
;             (gProcImg[OUT_digi_7] == (cam_add & 0x00FF)) &&         //lsb - old address
;                 (gProcImg[OUT_digi_8]<< 8 ==  (cam_add & 0xFF00)) &&
;                  !(Gen_Flags & Gen_Flags_Menu_Active) )
;     {
	.dbline 941
; 	    gProcImg[OUT_digi_6] = 0x00;
	clr _gProcImg+29
	.dbline 942
;         gProcImg[OUT_digi_7] = 0x00;
	clr _gProcImg+30
	.dbline 943
;         gProcImg[OUT_digi_8] = 0x00;
	clr _gProcImg+31
	.dbline 944
;         gProcImg[OUT_digi_4] = (cam_add & 0x00FF);
	ldd _cam_add
	anda #0
	andb #-1
	stab _gProcImg+27
	.dbline 945
;         gProcImg[OUT_digi_5] = (cam_add & 0xFF00)>>8;
	ldd _cam_add
	anda #-1
	andb #0
	tfr A,B
	clra
	stab _gProcImg+28
	.dbline 946
;         PORTA |= CAM_ON;       //turn camera on
	bset 0,#4
	.dbline 947
; 		if (MicOnOff.value == 2)
	movw _MicOnOff+2,2,-S
	movw _MicOnOff,2,-S
	movw #0,2,-S
	movw #16384,2,-S
	jsr cmpf4
	bne L477
	.dbline 948
; 		    mic_setEnabled(true);
	ldd #1
	xcall $_mic_setEnabled
L477:
	.dbline 951
; 
;         //turn off other cameras
;         gTxMsg.ID = 0x421;
	movw #1057,_gTxMsg
	.dbline 952
;         gTxMsg.LEN = 2; 
	movb #2,_gTxMsg+2
	.dbline 953
;         gTxMsg.BUF[0] = cam_add;
	ldab _cam_add+1
	stab _gTxMsg+4
	.dbline 954
;         gTxMsg.BUF[1] = cam_add >> 8;  
	ldd _cam_add
	tfr A,B
	clra
	stab _gTxMsg+4+1
	.dbline 955
; 		if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L483
	.dbline 956
;         {
	.dbline 958
;             // failed to transmit
;             MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 959
;         } 
L483:
	.dbline 961
; 			
;         MenuTimer = MenuTime * 2;
	movw #488,_MenuTimer
	.dbline 963
;       
;         gProcImg[OUT_digi_0] &= ~0x01;
	bclr _gProcImg+23,#1
	.dbline 965
; 		
;         Timer1 = RTI_One_Sec * .10;
	movw #97,_Timer1
L486:
	.dbline 966
;         while ( Timer1 );
L487:
	.dbline 966
	ldy _Timer1
	cpy #0
	bne L486
	.dbline 967
;         gProcImg[IN_digi_0] |= 0x01;
	bset _gProcImg,#1
	.dbline 968
;         MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	.dbline 969
;         Timer1 = RTI_One_Sec * .10;
	movw #97,_Timer1
L489:
	.dbline 970
;         while ( Timer1 );
L490:
	.dbline 970
	ldy _Timer1
	cpy #0
	bne L489
	.dbline 972
;                
;         StackPointer = 0;
	clr _StackPointer
	.dbline 973
;         MenuStackc[StackPointer].Index[0] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 974
;         MenuStackc[StackPointer].Index[1] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+1
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 975
;         MenuStackc[StackPointer].Index[2] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+2
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 976
;         MenuStackc[StackPointer].Index[3] = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 977
;         MenuStackc[StackPointer].CursorPos = 1;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+4
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #1
	stab 0,Y
	.dbline 978
;         MenuStackc[StackPointer].FirstLine = 0;
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+5
	tfr Y,D
	stx 4,S
	addd 4,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 979
;         Gen_Flags |= Gen_Flags_Menu_Active;
	bset _Gen_Flags,#1
	.dbline 981
;         
;         LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 4,S
	addd 4,S
	xcall $_LoadMenu
	.dbline 982
;         InsertCursor ();
	xcall $_InsertCursor
	.dbline 983
; 		UpdateMenu = 1;
	movb #1,_UpdateMenu
	.dbline 984
; 		AcceptKeys = 0;
	clr _AcceptKeys
	.dbline 985
;         CursorDownFlag = 0;
	clr _CursorDownFlag
	.dbline 986
;         CursorUpFlag = 0;
	clr _CursorUpFlag
	.dbline 987
;         SelectFlag = -1;
	movb #255,_SelectFlag
	.dbline 988
; 		Send_Menu_Status (0x01);
	ldd #1
	xcall $_Send_Menu_Status
	.dbline 989
;     }
L467:
	.dbline 991
; 
; 	if (AcceptKeys)
	ldab _AcceptKeys
	cmpb #0
	lbeq L497
	.dbline 992
; 	{
	.dbline 993
;     	if ( ( TC0_RCVD_Data & TeleData_Down ) && CursorDownFlag == 0 )
	ldd _TC0_RCVD_Data
	anda #0
	andb #1
	cpd #0
	beq L499
	ldab _CursorDownFlag
	cmpb #0
	bne L499
	.dbline 994
;     		CursorDownFlag = 1;
	movb #1,_CursorDownFlag
	bra L500
L499:
	.dbline 995
;     	else if ( CursorDownFlag == -1 && !( TC0_RCVD_Data & TeleData_Down ) )
	ldab _CursorDownFlag
	cmpb #65535
	bne L501
	ldd _TC0_RCVD_Data
	anda #0
	andb #1
	cpd #0
	bne L501
	.dbline 996
;     		CursorDownFlag = 0;
	clr _CursorDownFlag
L501:
L500:
	.dbline 998
;     
;     	if ( ( TC0_RCVD_Data &  TeleData_Up ) && CursorUpFlag == 0 )
	ldd _TC0_RCVD_Data
	anda #0
	andb #2
	cpd #0
	beq L503
	ldab _CursorUpFlag
	cmpb #0
	bne L503
	.dbline 999
;     		CursorUpFlag = 1;
	movb #1,_CursorUpFlag
	bra L504
L503:
	.dbline 1000
;     	else if ( CursorUpFlag == -1 && !( TC0_RCVD_Data & TeleData_Up ) )
	ldab _CursorUpFlag
	cmpb #65535
	bne L505
	ldd _TC0_RCVD_Data
	anda #0
	andb #2
	cpd #0
	bne L505
	.dbline 1001
;     		CursorUpFlag = 0;
	clr _CursorUpFlag
L505:
L504:
	.dbline 1003
;     
;     	if ( ( TC0_RCVD_Data & TeleData_Select ) && SelectFlag == 0 )
	ldd _TC0_RCVD_Data
	anda #0
	andb #4
	cpd #0
	beq L507
	ldab _SelectFlag
	cmpb #0
	bne L507
	.dbline 1004
;     		SelectFlag = 1;
	movb #1,_SelectFlag
	bra L508
L507:
	.dbline 1005
;     	else if ( SelectFlag == -1 && !( TC0_RCVD_Data & TeleData_Select ) )
	ldab _SelectFlag
	cmpb #65535
	bne L509
	ldd _TC0_RCVD_Data
	anda #0
	andb #4
	cpd #0
	bne L509
	.dbline 1006
;     		SelectFlag = 0;
	clr _SelectFlag
L509:
L508:
	.dbline 1007
; 	}
L497:
	.dbline 1009
; 	
; 	if ( !MenuTimer )
	ldy _MenuTimer
	cpy #0
	lbne L511
	.dbline 1010
; 	{
	.dbline 1011
; 		MenuTimer = (InProcess ? MenuTime*2.5 : MenuTime);
	ldab _InProcess
	cmpb #0
	beq L514
	movw #17432,6,S
	movw #38528,8,S
	bra L515
L514:
	movw #17268,6,S
	movw #9216,8,S
L515:
	ldd 8,S
	pshd
	ldd 8,S
	pshd
	jsr fp2int
	std _MenuTimer
	.dbline 1012
; 		AcceptKeys = 1;
	movb #1,_AcceptKeys
	.dbline 1014
; 		
; 		if ( Gen_Flags & Gen_Flags_Menu_Active )
	brclr _Gen_Flags,#1,X2
	bra X3
X2: lbra L516
X3:
	.dbline 1015
; 		{
	.dbline 1016
; 			if ( CursorDownFlag )
	ldab _CursorDownFlag
	cmpb #0
	beq L518
	.dbline 1017
; 			{
	.dbline 1018
; 				CursorDownFlag = -1;
	movb #255,_CursorDownFlag
	.dbline 1019
; 				CursorDown ();				
	xcall $_CursorDown
	.dbline 1020
; 			}
L518:
	.dbline 1021
; 			if ( CursorUpFlag )
	ldab _CursorUpFlag
	cmpb #0
	beq L520
	.dbline 1022
; 			{
	.dbline 1023
; 				CursorUpFlag = -1;
	movb #255,_CursorUpFlag
	.dbline 1024
; 				CursorUp ();			
	xcall $_CursorUp
	.dbline 1025
; 			}			 
L520:
	.dbline 1026
; 			if ( SelectFlag == 1)
	ldab _SelectFlag
	cmpb #1
	bne L522
	.dbline 1027
; 			{
	.dbline 1028
; 				MenuTimer = MenuTime * 2;                          //briefly disable select after menu is selected                 
	movw #488,_MenuTimer
	.dbline 1029
; 				Select();	
	xcall $_Select
	.dbline 1030
; 				SelectFlag = -1;		
	movb #255,_SelectFlag
	.dbline 1031
; 			}
L522:
	.dbline 1032
; 			if ( UpdateMenu )
	ldab _UpdateMenu
	cmpb #0
	beq L524
	.dbline 1033
; 			{
	.dbline 1034
; 				LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 4,S
	addd 4,S
	xcall $_LoadMenu
	.dbline 1035
; 				if ( !Variable_flag )
	ldab _Variable_flag
	cmpb #0
	bne L526
	.dbline 1036
; 					InsertCursor ();
	xcall $_InsertCursor
L526:
	.dbline 1037
; 				DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 1038
; 				UpdateMenu = 0;
	clr _UpdateMenu
	.dbline 1039
; 			}
L524:
	.dbline 1040
; 		}
L516:
	.dbline 1042
; 	
;         if ( UpdateMenu )
	ldab _UpdateMenu
	cmpb #0
	beq L528
	.dbline 1043
;         {
	.dbline 1044
;             if ( Gen_Flags & Gen_Flags_Menu_Active )
	brclr _Gen_Flags,#1,L530
	.dbline 1045
;             {
	.dbline 1046
;                 LoadMenu ( MenuStackc[StackPointer].Index );
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc
	tfr Y,D
	stx 4,S
	addd 4,S
	xcall $_LoadMenu
	.dbline 1047
;                 if ( !Variable_flag )
	ldab _Variable_flag
	cmpb #0
	bne L532
	.dbline 1048
;                     InsertCursor ();
	xcall $_InsertCursor
L532:
	.dbline 1049
;                 DisplayTitler ();
	xcall $_DisplayTitler
	.dbline 1050
;             }
	bra L531
L530:
	.dbline 1052
;             else
;             {
	.dbline 1053
;                 ClearTitler ();
	xcall $_ClearTitler
	.dbline 1054
;             }
L531:
	.dbline 1055
;             UpdateMenu = 0;
	clr _UpdateMenu
	.dbline 1056
;         }
L528:
	.dbline 1057
; 	}
L511:
	.dbline 1059
; 
;     if ( Gen_Flags & Gen_Flags_Menu_Active )
	brclr _Gen_Flags,#1,L534
	.dbline 1060
; 	    return 1;
	ldd #1
	bra L453
L534:
	.dbline 1062
; 	else
; 	    return 0;
	ldd #0
	.dbline -2
L453:
	.dbline 0 ; func end
	leas 13,S
	rtc
	.dbsym l CamAddressXmitd 10 c
	.dbsym l i 11 I
	.dbend
	.dbfunc e SetDefaultValues _SetDefaultValues fV
;     defaultPtr -> 0,SP
$_SetDefaultValues::
	pshd
	.dbline -1
	.dbline 1066
; } 
; 
; void SetDefaultValues(int defaultPtr)  //used when different defaults are needed (eg. for Machine size)
; {
	.dbline -2
L536:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l defaultPtr 0 I
	.dbend
	.dbfunc e Load_Variables _Load_Variables fV
;      EE_offset -> 4,SP
;        tempstr -> 6,SP
;            var -> 136,SP
;           cptr -> 138,SP
;          token -> 140,SP
$_Load_Variables::
	leas -142,S
	.dbline -1
	.dbline 1075
; 	/*UpdateVarByValue(&MachineSize, defaultPtr + 1);
; 	UpdateVarByValue(&Encoder_Gear, EG_defaults[defaultPtr]);
; 	UpdateVarByValue(&Large_Gear, LG_defaults[defaultPtr]);
; 	UpdateVarByValue(&GearRatio, GR_defaults[defaultPtr]);*/
; }
; 
; 
; void Load_Variables ( void )
; {
	.dbline 1076
;     int EE_offset=0;
	movw #0,4,S
	.dbline 1081
; 	char tempstr[130];
;     char *cptr,*token;
; 	struct menu_var *var;
; 
; 	if (*(char *)EE_Begin == 0xff) 
	ldab 0x800
	cmpb #255
	bne L538
	.dbline 1082
; 	{
	.dbline 1083
; 	    Save_Variables();
	xcall $_Save_Variables
	.dbline 1084
; 		return;
	lbra L537
L538:
	.dbline 1087
; 	}	
; 		
;     if (strlen((char *)EE_Begin) > 128)
	ldd #2048
	xcall $_strlen
	cpd #128
	bls L540
	.dbline 1088
; 	{
	.dbline 1089
; 	    tempstr[0] = 0xFF;
	movb #255,6,S
	.dbline 1090
; 		EEWrite ( 1, tempstr,(int *)(EE_Begin));      //Put a 0xff in the beginning of EEPROM to force defaults
	ldy #2048
	sty 2,S
	leay 6,S
	sty 0,S
	ldd #1
	xcall $_EEWrite
	.dbline 1091
; 		ResetProc ();
	xcall $_ResetProc
	.dbline 1092
; 		return;
	lbra L537
L540:
	.dbline 1095
; 	}
; 	
; 	strncpy(tempstr, (char *)EE_Begin, sizeof(tempstr));
	ldy #130
	sty 2,S
	ldy #2048
	sty 0,S
	leay 6,S
	tfr Y,D
	xcall $_strncpy
	.dbline 1096
;     token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 6,S
	tfr Y,D
	xcall $_strtok
	std 140,S
	.dbline 1098
; 
; 	for(cptr = (char *)&NullVar.str_value; cptr <= (char *)&NullVar2.str_value; cptr = cptr + sizeof(NullVar))
	ldy #_NullVar+18
	sty 138,S
	lbra L545
L542:
	.dbline 1099
; 	{
	.dbline 1100
; 		if (strlen(token) > STR_VALUE_LEN)
	ldd 140,S
	xcall $_strlen
	cpd #12
	bls L548
	.dbline 1101
;     	{
	.dbline 1102
; 	        tempstr[0] = 0xff;
	movb #255,6,S
	.dbline 1103
; 			EEWrite ( 1, tempstr,(int *)(EE_Begin));     //Put a 0xff in the beginning of EEPROM to force defaults
	ldy #2048
	sty 2,S
	leay 6,S
	sty 0,S
	ldd #1
	xcall $_EEWrite
	.dbline 1104
;     		ResetProc ();
	xcall $_ResetProc
	.dbline 1105
; 			return;
	lbra L537
L548:
	.dbline 1108
;     	}
; 		
; 		strncpy(cptr,token,STR_VALUE_LEN);
	ldy #12
	sty 2,S
	ldy 140,S
	sty 0,S
	ldd 138,S
	xcall $_strncpy
	.dbline 1109
; 		token = strtok(NULL, ",");
	ldy #L78
	sty 0,S
	ldd #0
	xcall $_strtok
	std 140,S
	.dbline 1110
; 		if ( token == NULL )
	cpd #0
	lbne L550
	.dbline 1111
; 		{
	.dbline 1112
; 		    EE_offset = EE_offset + 128;
	ldd 4,S
	addd #128
	std 4,S
	.dbline 1113
; 			if (!*(char *)(EE_Begin + EE_offset))
	addd #2048
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bne L552
	.dbline 1114
; 			    break; //Last variable loaded
	lbra L544
L552:
	.dbline 1115
;             if (strlen((char *)(EE_Begin + EE_offset)) > 128)
	ldd 4,S
	addd #2048
	xcall $_strlen
	cpd #128
	bls L554
	.dbline 1116
;         	{
	.dbline 1117
;         	    tempstr[0] = 0xff;
	movb #255,6,S
	.dbline 1118
;         		EEWrite ( 1, tempstr,(int *)(EE_Begin));   //Put a 0xff in the beginning of EEPROM to force defaults
	ldy #2048
	sty 2,S
	leay 6,S
	sty 0,S
	ldd #1
	xcall $_EEWrite
	.dbline 1119
;         		ResetProc ();
	xcall $_ResetProc
	.dbline 1120
; 				return;
	lbra L537
L554:
	.dbline 1122
;         	}
; 			strncpy(tempstr,(char *)(EE_Begin + EE_offset),sizeof(tempstr));
	ldy #130
	sty 2,S
	ldd 4,S
	addd #2048
	std 0,S
	leay 6,S
	tfr Y,D
	xcall $_strncpy
	.dbline 1123
; 			token = strtok(tempstr, ",");
	ldy #L78
	sty 0,S
	leay 6,S
	tfr Y,D
	xcall $_strtok
	std 140,S
	.dbline 1124
; 		}
L550:
	.dbline 1125
; 	}
L543:
	.dbline 1098
	ldd 138,S
	addd #34
	std 138,S
L545:
	.dbline 1098
	ldy #_NullVar2+18
	cpy 138,S
	lbhs L542
L544:
	.dbline 1127
; 		
; 	for(var=&NullVar; var<=&NullVar2; var=var+1)	
	ldy #_NullVar
	sty 136,S
	bra L559
L556:
	.dbline 1128
; 	{
	.dbline 1129
; 	    getvalue(var,0);
	ldy #0
	sty 0,S
	ldd 136,S
	xcall $_getvalue
	leas 4,S
	.dbline 1130
; 	}
L557:
	.dbline 1127
	ldd 136,S
	addd #34
	std 136,S
L559:
	.dbline 1127
	ldy #_NullVar2
	cpy 136,S
	bhs L556
	.dbline 1131
; 	strncpy(&EE_CamTag[0], &CamTag.str_value[0], STR_VALUE_LEN - 1); 
	ldy #11
	sty 2,S
	ldy #_CamTag+18
	sty 0,S
	ldd #_EE_CamTag
	xcall $_strncpy
	.dbline -2
L537:
	.dbline 0 ; func end
	leas 142,S
	rtc
	.dbsym l EE_offset 4 I
	.dbsym l tempstr 6 A[130:130]c
	.dbsym l var 136 pS[menu_var]
	.dbsym l cptr 138 pc
	.dbsym l token 140 pc
	.dbend
	.dbfunc e Load_Serial_Num _Load_Serial_Num fV
;        tempstr -> 2,SP
; VarEEPROMPntr2 -> 132,SP
$_Load_Serial_Num::
	leas -134,S
	.dbline -1
	.dbline 1137
; 	
; }
; 
; //retreive Serial Number from EEProm
; void Load_Serial_Num ( void )
; {
	.dbline 1141
;     char tempstr[130];
;     char *VarEEPROMPntr2;
; 	
;     VarEEPROMPntr2 = (char *)0xB10;
	leay 132,S
	movw #2832,0,y
	.dbline 1143
;     
;     if ( *VarEEPROMPntr2 >= '0' && *VarEEPROMPntr2 <= '9' )
	ldab [132,S]
	clra
	std 0,S
	cpd #48
	blt L562
	ldy 0,S
	cpy #57
	bgt L562
	.dbline 1144
; 	{
	.dbline 1145
;     	SerialNum.str_value[0] = *VarEEPROMPntr2;
	ldy 132,S
	movb 0,Y,_SerialNum+18
	.dbline 1146
;         SerialNum.str_value[1] = *(VarEEPROMPntr2 + 1);   
	ldy 132,S
	iny
	movb 0,Y,_SerialNum+18+1
	.dbline 1147
;         SerialNum.str_value[2] = *(VarEEPROMPntr2 + 2);   
	ldd 132,S
	addd #2
	tfr D,Y
	movb 0,Y,_SerialNum+18+2
	.dbline 1148
;         SerialNum.str_value[3] = *(VarEEPROMPntr2 + 3);   
	ldd 132,S
	addd #3
	tfr D,Y
	movb 0,Y,_SerialNum+18+3
	.dbline 1149
;         SerialNum.str_value[4] = *(VarEEPROMPntr2 + 4);   
	ldd 132,S
	addd #4
	tfr D,Y
	movb 0,Y,_SerialNum+18+4
	.dbline 1150
;         SerialNum.str_value[5] = *(VarEEPROMPntr2 + 5);     
	ldd 132,S
	addd #5
	tfr D,Y
	movb 0,Y,_SerialNum+18+5
	.dbline 1151
;         SerialNum.str_value[6] = 0;
	clr _SerialNum+18+6
	.dbline 1152
; 	}   
L562:
	.dbline -2
L561:
	.dbline 0 ; func end
	leas 134,S
	rtc
	.dbsym l tempstr 2 A[130:130]c
	.dbsym l VarEEPROMPntr2 132 pc
	.dbend
	.dbfunc e Save_Serial_Num _Save_Serial_Num fV
;      EEpromPtr -> 6,SP
$_Save_Serial_Num::
	leas -8,S
	.dbline -1
	.dbline 1156
; }
; 
; void Save_Serial_Num ( void )
; {
	.dbline 1161
;     char *EEpromPtr;
;     
; 	//This will prevent the serial number from being saved if there is already a number in EEPROM (first digit in EEPROM is numeric)
; 	//It will allow '------" to be saved (first digit in Serial Num Var is non numeric)
; 	if (*(char *)0xB10 >= '0' && *(char *)0xB10 <= '9' && SerialNum.str_value[0] >= '0' && SerialNum.str_value[0] <= '9')
	ldab 0xb10
	clra
	std 4,S
	cpd #48
	blt L578
	ldy 4,S
	cpy #57
	bgt L578
	ldab _SerialNum+18
	cmpb #48
	blo L578
	ldab _SerialNum+18
	cmpb #57
	bhi L578
	.dbline 1162
; 	{
	.dbline 1163
; 	    return;
	bra L577
L578:
	.dbline 1166
; 	}	
; 	
;     EEpromPtr = &SerialNum.str_value[0];
	ldy #_SerialNum+18
	sty 6,S
	.dbline 1168
; 
;  	EEWrite ( 7, EEpromPtr, (int *)0xB10 );
	ldy #2832
	sty 2,S
	ldy 6,S
	sty 0,S
	ldd #7
	xcall $_EEWrite
	.dbline -2
L577:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbsym l EEpromPtr 6 pc
	.dbend
	.dbfunc e Save_Variables _Save_Variables fV
;       Null_Ptr -> 12,SP
;      Null_Char -> 14,SP
;      EE_offset -> 15,SP
;        tempstr -> 17,SP
;         offset -> 147,SP
;           cptr -> 149,SP
$_Save_Variables::
	leas -151,S
	.dbline -1
	.dbline 1173
; }
; 
; 
; void Save_Variables ( void )
; {
	.dbline 1174
; 	int offset = 0, EE_offset = 0;
	leay 147,S
	movw #0,0,y
	.dbline 1174
	movw #0,15,S
	.dbline 1177
; 	char *cptr;
;     char tempstr[130];
; 	char Null_Char = NULL;
	clr 14,S
	.dbline 1178
; 	char *Null_Ptr = &Null_Char;
	leay 14,S
	sty 12,S
	.dbline 1180
; 
; 	for(cptr = (char *)&NullVar.str_value;  cptr <= (char *)&NullVar2.str_value;  cptr = cptr + sizeof(NullVar))
	ldy #_NullVar+18
	sty 149,S
	lbra L587
L584:
	.dbline 1181
; 	{
	.dbline 1182
; 	    if ((offset + strlen(cptr) + 1) < 128)
	ldd 149,S
	xcall $_strlen
	tfr D,X
	stx 10,S
	ldd 147,S
	addd 10,S
	tfr D,Y
	iny
	cpy #128
	bhs L590
	.dbline 1183
; 		    sprintf(tempstr + offset, "%s,", cptr);   //puts a comma
	ldy 149,S
	sty 4,S
	ldy #L592
	sty 2,S
	ldd 147,S
	leay 17,S
	sty 6,S
	addd 6,S
	std 0,S
	xcall $_sprintf
	bra L591
L590:
	.dbline 1185
; 		else
; 		    *(tempstr + offset - 1) = NULL;   //puts a null in place of the last comma
	ldd 147,S
	leay 16,S
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd #0
	stab 0,Y
L591:
	.dbline 1187
; 			
; 		offset = offset + strlen(cptr) + 1;
	ldd 149,S
	xcall $_strlen
	tfr D,X
	stx 8,S
	ldd 147,S
	addd 8,S
	tfr D,Y
	iny
	sty 147,S
	.dbline 1189
; 		
; 		if (offset > 127)   //current variable will go over the buffer limit
	cpy #127
	ble L594
	.dbline 1190
; 		{
	.dbline 1191
; 			EEWrite(128, tempstr, (int *)(EE_Begin + EE_offset));
	ldd 15,S
	addd #2048
	std 2,S
	leay 17,S
	sty 0,S
	ldd #128
	xcall $_EEWrite
	.dbline 1192
; 			EE_offset = EE_offset + 128;
	ldd 15,S
	addd #128
	std 15,S
	.dbline 1193
; 			sprintf(tempstr, "%s,", cptr);    //starts back over by putting the current variable at beginning of tempstr
	ldy 149,S
	sty 4,S
	ldy #L592
	sty 2,S
	leay 17,S
	sty 0,S
	xcall $_sprintf
	.dbline 1194
; 			offset = strlen(cptr) + 1;
	ldd 149,S
	xcall $_strlen
	tfr D,Y
	iny
	sty 147,S
	.dbline 1195
; 		}
L594:
	.dbline 1197
; 		
; 	}
L585:
	.dbline 1180
	ldd 149,S
	addd #34
	std 149,S
L587:
	.dbline 1180
	ldy #_NullVar2+18
	cpy 149,S
	lbhs L584
	.dbline 1199
; 	
; 	*(tempstr + offset - 1) = NULL;       //end the last string with a null
	ldd 147,S
	leay 16,S
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 1200
; 	EEWrite (128, tempstr, (int *)(EE_Begin + EE_offset));
	ldd 15,S
	addd #2048
	std 2,S
	leay 17,S
	sty 0,S
	ldd #128
	xcall $_EEWrite
	.dbline 1201
; 	EEWrite (1, Null_Ptr, (int *)(EE_Begin + EE_offset + 128));    //Put a Null in the first location of the next 128 byte block
	ldd 15,S
	addd #2176
	std 2,S
	ldy 12,S
	sty 0,S
	ldd #1
	xcall $_EEWrite
	.dbline 1202
;     strncpy(&EE_CamTag[0], &CamTag.str_value[0], STR_VALUE_LEN - 1); 
	ldy #11
	sty 2,S
	ldy #_CamTag+18
	sty 0,S
	ldd #_EE_CamTag
	xcall $_strncpy
	.dbline -2
L583:
	.dbline 0 ; func end
	leas 151,S
	rtc
	.dbsym l Null_Ptr 12 pc
	.dbsym l Null_Char 14 c
	.dbsym l EE_offset 15 I
	.dbsym l tempstr 17 A[130:130]c
	.dbsym l offset 147 I
	.dbsym l cptr 149 pc
	.dbend
	.area text
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e RestoreDefaults _RestoreDefaults fI
_RestoreDefaults::
	.dbline -1
	.dbline 1207
; }                                                                                        
; 
; 
; int RestoreDefaults ( void )
; {
	.dbline 1208
;     ClearTitler();
	xcall $_ClearTitler
	.dbline 1209
;  	NullVar.str_value[0] = 0xFF;
	movb #255,_NullVar+18
	.dbline 1210
;     Save_Variables();
	xcall $_Save_Variables
	.dbline 1211
;     ResetProc ();
	xcall $_ResetProc
	.dbline 1212
; 	return 0;
	ldd #0
	.dbline -2
L598:
	.dbline 0 ; func end
	rts
	.dbend
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
	.dbfunc e UpdateVarByValue _UpdateVarByValue fV
;            val -> 5,SP
;            var -> 0,SP
$_UpdateVarByValue::
	pshd
	.dbline -1
	.dbline 1216
; }
; 
; void UpdateVarByValue (struct menu_var *var, float val)
; {
	.dbline 1217
;     var->value = val;
	ldy 0,S
	ldd 7,S
	pshd
	ldd 7,S
	pshd
	pulx
	stx 0,Y
	pulx
	stx 2,Y
	.dbline 1218
; 	getstrval(var);
	ldd 0,S
	xcall $_getstrval
	.dbline -2
L600:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l val 5 D
	.dbsym l var 0 pS[menu_var]
	.dbend
	.dbfunc e UpdateVarByString _UpdateVarByString fV
;        str_val -> 7,SP
;            var -> 2,SP
$_UpdateVarByString::
	pshd
	leas -2,S
	.dbline -1
	.dbline 1222
; }
; 
; void UpdateVarByString (struct menu_var *var, char str_val[20])
; {
	.dbline 1223
;     strcpy(var->str_value, str_val);
	ldy 7,S
	sty 0,S
	ldd 2,S
	addd #18
	jsr _strcpy
	.dbline 1224
;     getvalue(var, 0);
	ldy #0
	sty 0,S
	ldd 2,S
	xcall $_getvalue
	leas 4,S
	.dbline -2
L601:
	.dbline 0 ; func end
	leas 4,S
	rtc
	.dbsym l str_val 7 pc
	.dbsym l var 2 pS[menu_var]
	.dbend
	.dbfunc e Send_Menu_Status _Send_Menu_Status fV
;           stat -> 1,SP
$_Send_Menu_Status::
	pshd
	.dbline -1
	.dbline 1228
; }
; 
; void Send_Menu_Status (char stat)
; {
	.dbline 1229
;     gTxMsg.ID = 0x200;
	movw #512,_gTxMsg
	.dbline 1230
;     gTxMsg.LEN = 1;
	movb #1,_gTxMsg+2
	.dbline 1231
;     gTxMsg.BUF[0] = stat;
	movb 1,S,_gTxMsg+4
	.dbline 1233
; 
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L605
	.dbline 1234
;     {
	.dbline 1236
;         // failed to transmit
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 1237
;     }
L605:
	.dbline -2
L602:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l stat 1 c
	.dbend
	.dbfunc e Update_Cam_List _Update_Cam_List fV
$_Update_Cam_List::
	.dbline -1
	.dbline 1241
; }
; 
; void Update_Cam_List(void)
; {
	.dbline 1242
;     gTxMsg.ID = 0x2A1;
	movw #673,_gTxMsg
	.dbline 1243
;     gTxMsg.LEN = 3;
	movb #3,_gTxMsg+2
	.dbline 1244
;     gTxMsg.BUF[0] = 0;
	clr _gTxMsg+4
	.dbline 1245
;     gTxMsg.BUF[1] = 0;
	clr _gTxMsg+4+1
	.dbline 1246
;     gTxMsg.BUF[2] = 0xFF;
	movb #255,_gTxMsg+4+2
	.dbline 1247
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L614
	.dbline 1248
;     {
	.dbline 1250
;         // failed to transmit
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 1251
;     }
L614:
	.dbline -2
L607:
	.dbline 0 ; func end
	rtc
	.dbend
	.dbfunc e DisplayMultiline _DisplayMultiline fV
;         length -> 4,SP
;        tempstr -> 6,SP
;              i -> 27,SP
;        endflag -> 37,SP
;         string -> 34,SP
;           line -> 29,SP
$_DisplayMultiline::
	pshd
	leas -29,S
	.dbline -1
	.dbline 1263
; }
; 
; //this function assumes you will always start with line 0 (top line) 
; //accepts max 21 characters
; //set end flag once done with multiline
; //usage example:
; //DisplayMultiline(0, "First line", 0);
; //DisplayMultiline(1, "second line", 0);
; //DisplayMultiline(2, "third line", 0);
; //DisplayMultiline(5, "last line", 1);
; void DisplayMultiline (int line, char string[21], bool endflag) 
; {
	.dbline 1268
;  	 unsigned int length;
; 	 char tempstr[21];
; 	 int i;
; 	 
; 	 strcpy(tempstr, string);
	ldy 34,S
	sty 0,S
	leay 6,S
	tfr Y,D
	jsr _strcpy
	.dbline 1270
; 	 
;  	 if (line == 0)
	ldy 29,S
	cpy #0
	bne L617
	.dbline 1271
; 	 	clearMenu();
	xcall $_clearMenu
L617:
	.dbline 1273
; 		
; 	 length = strlen(string);	
	ldd 34,S
	xcall $_strlen
	std 4,S
	.dbline 1275
; 
; 	 if (length < 20){
	cpd #20
	bhs L619
	.dbline 1275
	.dbline 1276
; 	    for(i = length; i < 20; i++){
	leax 27,S
	movw 4,S,0,x
	bra L624
L621:
	.dbline 1276
	.dbline 1277
; 			strcat(tempstr, " ");
	ldy #L101
	sty 0,S
	leay 6,S
	tfr Y,D
	xcall $_strcat
	.dbline 1278
; 		}  
L622:
	.dbline 1276
	ldy 27,S
	iny
	sty 27,S
L624:
	.dbline 1276
	ldy 27,S
	cpy #20
	blt L621
	.dbline 1279
; 	 }
L619:
	.dbline 1281
; 	 
; 	 strcpy(&Menu[line][0], tempstr);
	ldd #21
	leay 6,S
	sty 0,S
	ldy 29,S
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 2,S
	addd 2,S
	jsr _strcpy
	.dbline 1283
; 	 
; 	 if (endflag)
	ldab 37,S
	cmpb #0
	beq L625
	.dbline 1284
; 	 	DisplayTitler();
	xcall $_DisplayTitler
L625:
	.dbline -2
L616:
	.dbline 0 ; func end
	leas 31,S
	rtc
	.dbsym l length 4 i
	.dbsym l tempstr 6 A[21:21]c
	.dbsym l i 27 I
	.dbsym l endflag 37 c
	.dbsym l string 34 pc
	.dbsym l line 29 I
	.dbend
	.dbfunc e clearMenu _clearMenu fV
;              i -> 6,SP
$_clearMenu::
	leas -8,S
	.dbline -1
	.dbline 1288
; }
; 
; void clearMenu (void)
; {
	.dbline 1290
; 	 int i;
; 	 for (i=0; i<12; i++)
	movw #0,6,S
L628:
	.dbline 1291
; 	 {
	.dbline 1292
; 	 	 sprintf (&Menu[i][0],"                    ");  //20 spaces
	ldd #21
	ldy #L632
	sty 2,S
	ldy 6,S
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 4,S
	addd 4,S
	std 0,S
	xcall $_sprintf
	.dbline 1293
; 	 }
L629:
	.dbline 1290
	ldy 6,S
	iny
	sty 6,S
	.dbline 1290
	cpy #12
	blt L628
	.dbline -2
L627:
	.dbline 0 ; func end
	leas 8,S
	rtc
	.dbsym l i 6 I
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
_InProcess::
	.blkb 1
	.dbsym e InProcess _InProcess c
_AcceptKeys::
	.blkb 1
	.dbsym e AcceptKeys _AcceptKeys c
_SelectFlag::
	.blkb 1
	.dbsym e SelectFlag _SelectFlag c
_CursorUpFlag::
	.blkb 1
	.dbsym e CursorUpFlag _CursorUpFlag c
_CursorDownFlag::
	.blkb 1
	.dbsym e CursorDownFlag _CursorDownFlag c
_EE_CamTag::
	.blkb 12
	.dbsym e EE_CamTag _EE_CamTag A[12:12]c
	.area text
	.dbfile C:\Dev\REV1~1.01\MenuFunctions.c
L632:
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
L592:
	.byte 37,'s,44,0
L113:
	.byte 37,42,'s,37,46,42,'f,0
L112:
	.byte 37,42,'s,37,35,46,42,'f,0
L101:
	.byte 32,0
L100:
	.byte 37,42,'s,37,'s,0
L78:
	.byte 44,0
