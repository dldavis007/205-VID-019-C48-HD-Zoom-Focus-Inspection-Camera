	.module Subroutines.c
	.area text
	.dbfile ..\REV1~1.01\Subroutines.c
	.area data
	.dbfile ..\REV1~1.01\Subroutines.c
_State::
	.blkb 1
	.area idata
	.byte 99
	.area data
	.dbfile ..\REV1~1.01\Subroutines.c
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e State _State c
_ran_num::
	.blkb 2
	.area idata
	.word 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e ran_num _ran_num i
_DiagMenuActive::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e DiagMenuActive _DiagMenuActive c
_micChanged::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e micChanged _micChanged c
	.area text
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
_enum_NULL_str::
	.byte 0
	.dbsym e enum_NULL_str _enum_NULL_str A[1:1]c
_enum_off_on_str::
	.byte 'O,'F,'F,44,32,'O,'N,0
	.dbsym e enum_off_on_str _enum_off_on_str A[8:8]c
_enum_polarity_str::
	.byte 'P,'O,'S,44,'N,'E,'G,0
	.dbsym e enum_polarity_str _enum_polarity_str A[8:8]c
_enum_angle_dir_str::
	.byte 32,'C,'W,44,'C,'C,'W,0
	.dbsym e enum_angle_dir_str _enum_angle_dir_str A[8:8]c
_enum_size_str::
	.byte 32,56,44,49,50,44,50,52,0
	.dbsym e enum_size_str _enum_size_str A[9:9]c
_enum_encoder_str::
	.byte 50,53,44,51,50,44,53,48,44,54,52,44,49,48,48,44
	.byte 49,50,56,44,50,53,54,44,53,49,50,0
	.dbsym e enum_encoder_str _enum_encoder_str A[28:28]c
_enum_alpha_str::
	.byte 32,44,'A,44,'B,44,'C,44,'D,44,'E,44,'F,44,'G,44
	.byte 'H,44,'I,44,'J,44,'K,44,'L,44,'M,44,'N,44,'O,44
	.byte 'P,44,'Q,44,'R,44,'S,44,'T,44,'U,44,'V,44,'W,44
	.byte 'X,44,'Y,44,'Z,44,48,44,49,44,50,44,51,44,52,44
	.byte 53,44,54,44,55,44,56,44,57,44,46,44,60,44,62,44
	.byte 59,44,58,44,64,44,40,44,41,44,45,44,45,0
	.dbsym e enum_alpha_str _enum_alpha_str A[94:94]c
_enum_number_str::
	.byte 48,44,49,44,50,44,51,44,52,44,53,44,54,44,55,44
	.byte 56,44,57,44,45,0
	.dbsym e enum_number_str _enum_number_str A[22:22]c
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
_SerialNum::
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4120,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 249
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 8
	.area idata
	.byte 45,45,45,45,45,45,45,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.byte 0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_number_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
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
	.dbsym e SerialNum _SerialNum S[menu_var]
_Rev::
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4238,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 252
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 49,46,48,50,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_alpha_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e Rev _Rev S[menu_var]
_NullVar::
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 32,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 10
	.area idata
	.byte 0,0,0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_NULL_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e NullVar _NullVar S[menu_var]
_CamTag::
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4238,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 245
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 12
	.area idata
	.byte 'H,'D,32,'I,'N,'S,'P,32,'C,'A,'M,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_alpha_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e CamTag _CamTag S[menu_var]
_disp_add::
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4238,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 252
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 49,50,51,52,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_alpha_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e disp_add _disp_add S[menu_var]
_MicOnOff::
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 4
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 32,32,'O,'N,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_off_on_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e MicOnOff _MicOnOff S[menu_var]
_LEDLevel::
	.blkb 4
	.area idata
	.word 0x4110,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4110,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 4
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 32,32,32,56,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_number_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e LEDLevel _LEDLevel S[menu_var]
_LightAlwaysOnOnOff::
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 4
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 32,32,'O,'N,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_off_on_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e LightAlwaysOnOnOff _LightAlwaysOnOnOff S[menu_var]
_VideoRelayDiag::
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x3f80,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x4000,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 4
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 5
	.area idata
	.byte 32,32,'O,'N,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 7
	.area idata
	.byte 0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_off_on_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e VideoRelayDiag _VideoRelayDiag S[menu_var]
_NullVar2::
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 4
	.area idata
	.word 0x0,0x0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 32,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 10
	.area idata
	.byte 0,0,0,0,0,0,0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkw 1
	.area idata
	.word _enum_NULL_str
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e NullVar2 _NullVar2 S[menu_var]
	.area text
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
_Menuc::
	.byte 0,0
	.byte 0,0
	.byte 32,32,32,32,32,32,'H,'D,32,'C,'A,'M,'E,'R,'A,32
	.byte 32,32,32,32,0
	.byte 32,'S,'E,'T,'T,'I,'N,'G,'S,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'D,'I,'A,'G,'N,'O,'S,'T,'I,'C,'S,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'S,'T,'A,'T,'U,'S,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'D,'E,'F,'A,'U,'L,'T,'S,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'E,'X,'I,'T,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _ExitMenu
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.byte 0,0
	.byte 0,1
	.byte 32,32,32,'C,'A,'M,'E,'R,'A,32,'S,'E,'T,'T,'I,'N
	.byte 'G,'S,32,32,0
	.byte 32,'T,'A,'G,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'M,'I,'C,'R,'O,'P,'H,'O,'N,'E,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'L,'E,'D,32,'L,'I,'G,'H,'T,'S,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'L,'E,'D,32,'A,'L,'W,'A,'Y,'S,32,'O,'N,32,32
	.byte 32,32,32,32,0
	.byte 32,'E,'X,'I,'T,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 9,16
	.byte 16,16
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0
	.word _CamTag
	.word _MicOnOff
	.word _LEDLevel
	.word _LightAlwaysOnOnOff
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _StdVarFunction
	.word _StdVarFunction
	.word _StdVarFunction
	.word _StdVarFunction
	.word _ExitMenu
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.byte 0,0
	.byte 0,2
	.byte 32,'C,'A,'M,'E,'R,'A,32,'D,'I,'A,'G,'N,'O,'S,'T
	.byte 'I,'C,'S,32,0
	.byte 32,'V,'I,'D,'E,'O,32,'R,'E,'L,'A,'Y,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'E,'X,'I,'T,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 16,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0
	.word _VideoRelayDiag
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _StdVarFunction
	.word _ExitMenu
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.byte 0,0
	.byte 0,3
	.byte 32,32,32,32,32,'S,'T,'A,'T,'U,'S,32,'M,'E,'N,'U
	.byte 32,32,32,32,0
	.byte 32,'S,'O,'F,'T,'W,'A,'R,'E,32,'R,'E,'V,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'C,'A,'M,'E,'R,'A,32,'I,'D,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'S,'E,'R,'I,'A,'L,32,'N,'U,'M,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'E,'X,'I,'T,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 16,16
	.byte 12,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0
	.word _Rev
	.word _disp_add
	.word _SerialNum
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullFunction
	.word _NullFunction
	.word _SerVarFunction
	.word _ExitMenu
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.byte 0,0
	.byte 0,4
	.byte 32,32,32,32,32,'D,'E,'F,'A,'U,'L,'T,'S,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'E,'X,'I,'T,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,'R,'E,'S,'T,'O,'R,'E,32,'D,'E,'F,'A,'U,'L,'T
	.byte 'S,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,'W,'A,'R,'N,'I,'N,'G,32,32,32
	.byte 32,32,32,32,0
	.byte 'Y,'O,'U,32,'W,'I,'L,'L,32,'L,'O,'S,'E,32,'A,'L
	.byte 'L,32,32,32,0
	.byte 'O,'F,32,'T,'H,'E,32,'C,'U,'R,'R,'E,'N,'T,32,32
	.byte 32,32,32,32,0
	.byte 'S,'E,'T,'T,'I,'N,'G,'S,32,'W,'H,'E,'N,32,32,32
	.byte 32,32,32,32,0
	.byte 'R,'E,'S,'T,'O,'R,'I,'N,'G,32,'D,'E,'F,'A,'U,'L
	.byte 'T,'S,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0,0
	.byte 0
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _NullVar
	.word _ExitMenu
	.word _RestoreDefaults
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word _NullFunction
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0
	.dbstruct 0 311 MenuStruct
	.dbfield 0 Index A[4:4]c
	.dbfield 4 Entry A[252:12:21]c
	.dbfield 256 Pos A[11:11]c
	.dbfield 267 VarPntr A[22:11]pS[menu_var]
	.dbfield 289 FunctPtr A[22:11]pfI
	.dbend
	.dbsym e Menuc _Menuc A[1866:6]S[MenuStruct]
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
_MenuStackc::
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 2
	.area idata
	.byte 0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 1
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.blkb 24
	.area idata
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0,0,0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbstruct 0 6 MenuStack
	.dbfield 0 Index A[4:4]c
	.dbfield 4 CursorPos c
	.dbfield 5 FirstLine c
	.dbend
	.dbsym e MenuStackc _MenuStackc A[30:5]S[MenuStack]
_StackPointer::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e StackPointer _StackPointer c
_Variable_flag::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e Variable_flag _Variable_flag c
_String_Var_ptr::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e String_Var_ptr _String_Var_ptr c
_Multi_Var_ptr::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e Multi_Var_ptr _Multi_Var_ptr c
_F1pressed::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e F1pressed _F1pressed c
_F2pressed::
	.blkb 1
	.area idata
	.byte 0
	.area data
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbsym e F2pressed _F2pressed c
	.area extcode(paged)
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
	.dbfunc e doevents _doevents fV
;        tempstr -> 81,SP
;              i -> 99,SP
;      Disp_Line -> 17,SP
$_doevents::
	leas -101,S
	.dbline -1
	.dbline 361
; #include <stdio.h>
; #include <string.h>
; #include <stdlib.h>
; #include <math.h>
; 
; #include "nodecfg.h"
; #include "Subroutines.h"
; #include "mc9s12a128.h"
; #include "Interrupts.h"
; #include "mco.h"
; #include "mcohw.h"
; #include "EEProm.h"
; #include "MenuFunctions.h"
; #include "Camera.h"
; #include "DAC101S101.h"
; 
; #include "Packets.h"
; #include "CamMenu.h"
; 
; extern unsigned int Titler_Timer;
; unsigned int i,j,k;
; unsigned char Line_prev[4][20];
; 
; CAN_MSG gTxMsg;
; char UpdateMenu;
; char State = FinishState;
; char CANBuf[15];
; 
; char Cam_Message[9];
; char OSD_changed;
; unsigned char Line[4][20];
; 
; unsigned int cam_add;
; unsigned int ran_num = 0;  //used to create unique camera address  
; 
; extern char Gen_Flags;
; extern unsigned int TC0_RCVD_Data;
; extern unsigned int MenuTimer;
; extern unsigned int BootUpTimer;
; extern int Update_Menu_Timer;
; extern unsigned int Timer1;
; 
; extern float testTime;
; extern float storeTestTime;
; extern unsigned int TestTimer;
; 
; //extern char SIN0Buf[SIN0BufLen];
; extern int SIN0Bufptr;
; //extern char SOUT0Buf[SOUT0BufLen];
; extern int SOUT0Bufptr;
; 
; //extern char SIN1Buf[SIN1BufLen];
; extern int SIN1Bufptr;
; //extern char SOUT0Buf[SOUT0BufLen];
; extern int SOUT1Bufptr;
; 
; bool DiagMenuActive = false;
; 
; bool micChanged = false;
; char lastMicSetting[5];
; 
; char lastResSetting[5];
; 
; //struct menu_var{
; //float value;            //actual value of the variable, or pointer to enum list if an enum type variable, In "String type" var this points to the char that String_Var_ptr points to
; //float inc;              //increment/decrement value, may be int or float, must be 1 for enum type variable
; //float min;              //minimum value of variable, may be int or float, must point to first enum in list for enum type variable
; //float max;              //maximum value of variable, may be int or float, must point to last enum in list for enum type variable
; //int dec_pos;            //decimal position, zero if variable is an int or an enum
; //int len_str;			  //length of str_value, pads left with spaces, Make this negative for "String type" variables (serial num, camera tag, etc.)
; //char str_value[20];     //string equivalent of value, or current enum pointed to by value, or current "String type" variable
; //char *str_enum;         //pointer to comma separated enum list, must be NULL for non-enum variable types
; //struct menu_var *next_var;
; //};
; 
; 
; //Enum strings have a maximum length of 100 chars including the Null
; const char enum_NULL_str[]="";
; const char enum_off_on_str[]="OFF, ON";
; const char enum_polarity_str[]="POS,NEG";
; const char enum_angle_dir_str[]=" CW,CCW";
; const char enum_size_str[]=" 8,12,24";
; const char enum_encoder_str[]="25,32,50,64,100,128,256,512";
; const char enum_alpha_str[]=" ,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,.,<,>,;,:,@,(,),-,-"; //last char is the cursor char, do not count for max
; const char enum_number_str[]="0,1,2,3,4,5,6,7,8,9,-";  //last char is the cursor char, do not count for max
; 
; //default arrays                               
; //const int EG_defaults[] = {18, 16, 24};            //encoder gear
; //const int LG_defaults[] = {83, 74, 120};           //large gear
; //const double GR_defaults[] = {4.61, 4.63, 5.00};   //gear ratio
; 
; 
; //saved seperately at 0xB10
; struct menu_var SerialNum = {
; 	   1,1,1,10,0,-7,"-------",enum_number_str
; };
; 
; //saved seperately at 0x0900
; char cam_addx[2];      //unique camera address from ran_num
; 
; 
; //The following Menu Variables are NOT saved in EEPROM
; struct menu_var Rev = {
; 	   1,1,1,46,0,-4,Revision,enum_alpha_str   //display only
; }; 
; 
; 
; 
; //The following Menu Variables ARE saved in EEPROM
; struct menu_var  NullVar = {
; 	   0,0,0,0,0,0," ",enum_NULL_str
; }; 
; 
; struct menu_var CamTag = {
; 	   1,1,1,46,0,-11,"HD INSP CAM",enum_alpha_str   //display only
; }; 
; 
; struct menu_var disp_add = {
; 	   1,1,1,46,0,-4,"1234",enum_alpha_str
; }; 
; 
; struct menu_var MicOnOff = {
; 	   2,1,1,2,0,4,"  ON",enum_off_on_str
; }; 
; 
; struct menu_var LEDLevel = {
;     9,1,1,9,0,4,"   8",enum_number_str
; };
; 
; struct menu_var LightAlwaysOnOnOff = {
; 	   2,1,1,2,0,4,"  ON",enum_off_on_str
; };
; 
; struct menu_var VideoRelayDiag = {
; 	   2,1,1,2,0,4,"  ON",enum_off_on_str
; };
; 					   
; struct menu_var  NullVar2 = {
; 	   0,0,0,0,0,0," ",enum_NULL_str
; };
; 
; 
; 
; struct MenuStruct const Menuc[MenuSize] = {     
;                                         0,0,0,0,
;                                         "      HD CAMERA     ",
;                                         " SETTINGS           ",
;                                         " DIAGNOSTICS        ",
;                                         " STATUS             ",
;                                         " DEFAULTS           ",
;                                         " EXIT               ",
;                                         "                    ",
;                                         "                    ",
;                                         "                    ",
;                                         "                    ",
;                                         "                    ",
;                                         "                    ",
;                                         0,0,0,0,0,0,0,0,0,0,0,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullVar,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         &ExitMenu,
;                                         &NullFunction,
; 										&NullFunction,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         &NullFunction,
;                                         
;                                             0,0,0,1,
;                                             "   CAMERA SETTINGS  ",
; 											" TAG                ",
; 											" MICROPHONE         ",
; 											" LED LIGHTS         ",
; 											" LED ALWAYS ON      ",
;                                             " EXIT               ",	
; 											"                    ",
; 											"                    ",
; 											"                    ",						
; 											"                    ",
; 											"                    ",
; 											"                    ",
; 											9,16,16,16,0,0,0,0,0,0,0,
;                                             &CamTag,
;                                             &MicOnOff,
; 											&LEDLevel,
;                                             &LightAlwaysOnOnOff,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &StdVarFunction,
; 											&StdVarFunction,
;                                             &StdVarFunction,
;                                             &StdVarFunction,
; 											&ExitMenu,
; 											&NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
; 											&NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
; 																				                                                      
;                                             0,0,0,2,
;                                             " CAMERA DIAGNOSTICS ",
; 											" VIDEO RELAY        ",
; 											" EXIT               ",
;                                             "                    ",
; 											"                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             16,0,0,0,0,0,0,0,0,0,0,
;                                             &VideoRelayDiag,
;                                             &NullVar,
; 											&NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &StdVarFunction,
;                                             &ExitMenu,
; 											&NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
; 											&NullFunction,
; 											&NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                                                                          
;                                             0,0,0,3,
;                                             "     STATUS MENU    ",
;                                             " SOFTWARE REV       ",
; 											" CAMERA ID          ",
;                                             " SERIAL NUM         ",
;                                             " EXIT               ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             16,16,12,0,0,0,0,0,0,0,0,
;                                             &Rev,
;                                             &disp_add,
;                                             &SerialNum,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullFunction,
; 											&NullFunction,
;                                             &SerVarFunction,
;                                             &ExitMenu,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             
;                                             0,0,0,4,
;                                             "     DEFAULTS       ",
;                                             " EXIT               ",
;                                             " RESTORE DEFAULTS   ",
;                                             "                    ",
;                                             "      WARNING       ",
;                                             "YOU WILL LOSE ALL   ",
;                                             "OF THE CURRENT      ",
;                                             "SETTINGS WHEN       ",
;                                             "RESTORING DEFAULTS  ",
;                                             "                    ",
;                                             "                    ",
;                                             "                    ",
;                                             0,0,0,0,0,0,0,0,0,0,0,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &NullVar,
;                                             &ExitMenu,
;                                             &RestoreDefaults,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction,
;                                             &NullFunction
;  
; };
; 
; struct MenuStack MenuStackc[MenuStackSize] = {0,0,0,0,1,0};
; 
; char StackPointer = 0;
; 
; char Menu[12][21];
; 
; char Variable_flag = 0;
; char String_Var_ptr = 0;
; char Multi_Var_ptr = 0;
; 
; 
; 
; 
; /***************************************************************************/ 
; 
; //external declaration for the process image array
; extern UNSIGNED8 gProcImg[];
; 
; /**************************************************************************/
; 
; bool F1pressed = false, F2pressed = false;
; 
; unsigned char TitlerState;
; extern char Rcv_Packet_Data[128];		
; extern char Popup_Menu_Act;
; extern char CamMenu,PosMenu,CamStartup;
; //extern int boot_timer;
; 
; void doevents ( void )
; {	
	.dbline 362
;     if(CamStartup){
	ldab _CamStartup
	cmpb #0
	beq L7
	.dbline 362
	.dbline 363
;         if(2 == LightAlwaysOnOnOff.value){
	movw _LightAlwaysOnOnOff+2,2,-S
	movw _LightAlwaysOnOnOff,2,-S
	movw #0,2,-S
	movw #16384,2,-S
	jsr cmpf4
	bne L9
	.dbline 363
	.dbline 364
;             set_LED_Level(LEDLevel.value);
	movw _LEDLevel+2,2,-S
	movw _LEDLevel,2,-S
	jsr fp2int
	xcall $_set_LED_Level
	.dbline 365
;         }
L9:
	.dbline 366
;         CamStartup=0;
	clr _CamStartup
	.dbline 368
;         //Init_Cam();
;     }
L7:
	.dbline 370
; 		
; 	if (receivePackets(Rcv_Packet_Data)) {
	ldd #_Rcv_Packet_Data
	xcall $_receivePackets
	clra
	cmpb #0
	beq L11
	.dbline 370
	.dbline 371
; 		Add_Cam_command(Rcv_Packet_Data,0);
	ldy #0
	sty 0,S
	ldd #_Rcv_Packet_Data
	xcall $_Add_Cam_command
	.dbline 372
; 	}
L11:
	.dbline 375
; 	
; 
; 	if (gProcImg[OUT_digi_1] & 0b10000000 && (VSEL_PORT & CAM_ON)) 
	brclr _gProcImg+24,#128,L13
	brclr 0,#4,L13
	.dbline 376
; 	{
	.dbline 377
; 		if (PosMenu)
	ldab _PosMenu
	cmpb #0
	beq L16
	.dbline 378
; 		    Popup_Menu_Act = 0;
	clr _Popup_Menu_Act
L16:
	.dbline 379
; 		    Cam_Menu_Funct();
	xcall $_Cam_Menu_Funct
	.dbline 380
; 		if (CamMenu && TitlerState || PosMenu)
	ldab _CamMenu
	cmpb #0
	beq L21
	ldab _TitlerState
	cmpb #0
	bne L20
L21:
	ldab _PosMenu
	cmpb #0
	beq L18
L20:
	.dbline 381
; 		{
	.dbline 382
; 		    TitlerState=0;		   // This clears the menu when the Camera Menu is active
	clr _TitlerState
	.dbline 383
; 			UpdateMenu = 1;	   	   // Forces an update in InspectionCam_Main
	movb #1,_UpdateMenu
	.dbline 384
; 		}
	bra L19
L18:
	.dbline 385
; 		else if (!CamMenu)
	ldab _CamMenu
	cmpb #0
	bne L22
	.dbline 386
; 		{
	.dbline 387
; 		    if(!TitlerState)
	ldab _TitlerState
	cmpb #0
	bne L24
	.dbline 389
; 			    //UpdateMenu = 1;	   // This Updates the menu when the Camera Menu becomes inactive
; 			TitlerState=1;
	movb #1,_TitlerState
L24:
	.dbline 390
; 		}
L22:
L19:
	.dbline 391
; 		PosMenu = 0;
	clr _PosMenu
	.dbline 393
; //		gProcImg[IN_digi_0] |= 0x01;
; 	}
	lbra L14
L13:
	.dbline 394
; 	else if (gProcImg[OUT_digi_1] & 0b01000000 && (VSEL_PORT & CAM_ON))
	brclr _gProcImg+24,#64,X0
	bra X1
X0: lbra L26
X1:
	brclr 0,#4,X2
	bra X3
X2: lbra L26
X3:
	.dbline 395
; 	{
	.dbline 396
; 		if (!PosMenu)
	ldab _PosMenu
	cmpb #0
	bne L29
	.dbline 397
; 		    Popup_Menu_Act = 0;
	clr _Popup_Menu_Act
L29:
	.dbline 398
; 		if (CamMenu)
	ldab _CamMenu
	cmpb #0
	beq L31
	.dbline 399
; 		    Add_Cam_command("\x81\x01\x70\x01\x27\xFF",0);
	ldy #0
	sty 0,S
	ldd #L33
	xcall $_Add_Cam_command
L31:
	.dbline 400
; 		Cam_Menu_Funct();
	xcall $_Cam_Menu_Funct
	.dbline 401
; 		if (!PosMenu)
	ldab _PosMenu
	cmpb #0
	bne L34
	.dbline 402
; 		{
	.dbline 403
; 		    TitlerState=0;		  // This updates the menu with the "Position Active" text
	clr _TitlerState
	.dbline 404
; 			UpdateMenu = 1;
	movb #1,_UpdateMenu
	.dbline 405
; 			strncpy(&Line[0][0]," POSITION ACTIVE    ",20);
	ldy #20
	sty 2,S
	ldy #L36
	sty 0,S
	ldd #_Line
	xcall $_strncpy
	.dbline 406
; 		}
	bra L35
L34:
	.dbline 407
; 		else if (PosMenu)
	ldab _PosMenu
	cmpb #0
	beq L37
	.dbline 408
; 		{
	.dbline 409
; 		    if(!TitlerState)
	ldab _TitlerState
	cmpb #0
	bne L39
	.dbline 410
; 			    UpdateMenu = 1;
	movb #1,_UpdateMenu
L39:
	.dbline 411
; 			TitlerState=1;
	movb #1,_TitlerState
	.dbline 412
; 		}
L37:
L35:
	.dbline 413
; 		PosMenu = 1;
	movb #1,_PosMenu
	.dbline 414
; 		CamMenu = 0;
	clr _CamMenu
	.dbline 416
; //		gProcImg[IN_digi_0] |= 0x01;
; 	}
	bra L27
L26:
	.dbline 417
; 	else if (Popup_Menu_Act)
	ldab _Popup_Menu_Act
	cmpb #0
	beq L41
	.dbline 418
; 	{
	.dbline 419
; 	    Popup_Menu_Act = 0;
	clr _Popup_Menu_Act
	.dbline 421
; //		Display("Proc:               ");
; 		CamMenu = 0;
	clr _CamMenu
	.dbline 422
; 		PosMenu = 0;
	clr _PosMenu
	.dbline 423
; 		TitlerState=0;
	clr _TitlerState
	.dbline 424
; 		ClearTitler();
	xcall $_ClearTitler
	.dbline 425
; 		Add_Cam_command("\x81\x01\x70\x01\x27\xFF",0);
	ldy #0
	sty 0,S
	ldd #L33
	xcall $_Add_Cam_command
	.dbline 426
; 		if(Gen_Flags & GEN_FLAGS_MENU_ACTIVE)
	brclr _Gen_Flags,#8,L43
	.dbline 427
; 		    UpdateMenu = 1;
	movb #1,_UpdateMenu
L43:
	.dbline 429
; //		gProcImg[IN_digi_0] &= ~0x01;
; 	}
L41:
L27:
L14:
	.dbline 434
; 		
; 	
; 	
; 	
; 	if (TC0_RCVD_Data & TeleData_Reset)
	ldd _TC0_RCVD_Data
	anda #2
	andb #0
	cpd #0
	beq L45
	.dbline 435
; 	    ResetProc();
	xcall $_ResetProc
L45:
	.dbline 439
; 		
; 		
; 	//if the 2-Wire system is working, start updating the 2-Wire Stack
; 	if (!BootUpTimer && !(Gen_Flags & Gen_Flags_No2Wire))
	ldy _BootUpTimer
	cpy #0
	lbne L47
	ldab _Gen_Flags
	bitb #32
	lbne L47
	.dbline 440
; 	{
	.dbline 441
; 	    MCO_ProcessStack();// Operate on CANopen protocol stack
	xcall $_MCO_ProcessStack
	.dbline 443
; 	
; 		menu_function();
	xcall $_menu_function
	.dbline 445
; 		
; 		++ran_num;
	ldy _ran_num
	iny
	sty _ran_num
	.dbline 447
; 		
; 		sprintf ( disp_add.str_value, "%04X", cam_add );    //for status diplay of camera address
	ldy _cam_add
	sty 4,S
	ldy #L50
	sty 2,S
	ldy #_disp_add+18
	sty 0,S
	xcall $_sprintf
	.dbline 449
; 		
;         if(MenuStackc[StackPointer].Index[3] == 2)
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #2
	bne L51
	.dbline 450
;         {
	.dbline 451
;             if(VideoRelayDiag.value == 1)
	movw _VideoRelayDiag+2,2,-S
	movw _VideoRelayDiag,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr cmpf4
	bne L54
	.dbline 452
;             {    
	.dbline 453
;                 PORTA &= ~CAM_ON;       //turn camera off
	bclr 0,#4
	.dbline 454
;             }
	bra L55
L54:
	.dbline 456
;             else
;             {
	.dbline 457
;                 PORTA |= CAM_ON;       //turn camera on
	bset 0,#4
	.dbline 458
;             }
L55:
	.dbline 459
;             DiagMenuActive = true;
	movb #1,_DiagMenuActive
	.dbline 460
;         }
L51:
	.dbline 461
;         if(DiagMenuActive && VideoRelayDiag.value == 1 && MenuStackc[StackPointer].Index[3] != 2 )
	ldab _DiagMenuActive
	cmpb #0
	beq L56
	movw _VideoRelayDiag+2,2,-S
	movw _VideoRelayDiag,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr cmpf4
	bne L56
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #2
	beq L56
	.dbline 462
;         {
	.dbline 463
;             VideoRelayDiag.value = 2;
	movw #16384,_VideoRelayDiag
	movw #0,_VideoRelayDiag+2
	.dbline 464
;             PORTA |= CAM_ON;       //turn camera on
	bset 0,#4
	.dbline 465
;             DiagMenuActive = false;
	clr _DiagMenuActive
	.dbline 467
; 
;         }
L56:
	.dbline 470
;         
;         //LED Level setting change
;         if(MenuStackc[StackPointer].Index[3] == 1 && strcmp(LEDLevel.str_value, lastResSetting))
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #1
	bne L59
	ldy #_lastResSetting
	sty 0,S
	ldd #_LEDLevel+18
	xcall $_strcmp
	cpd #0
	beq L59
	.dbline 471
;         {
	.dbline 472
;             set_LED_Level(LEDLevel.value);
	movw _LEDLevel+2,2,-S
	movw _LEDLevel,2,-S
	jsr fp2int
	xcall $_set_LED_Level
	.dbline 473
;         }
L59:
	.dbline 475
; 
;         strcpy(lastResSetting, LEDLevel.str_value);
	ldy #_LEDLevel+18
	sty 0,S
	ldd #_lastResSetting
	jsr _strcpy
	.dbline 478
; 
; 		//MicOnOff setting changed
;    		if(MenuStackc[StackPointer].Index[3] == 1 && strcmp(MicOnOff.str_value, lastMicSetting))
	ldab _StackPointer
	clra
	tfr D,Y
	ldd #6
	emul
	tfr D,Y
	ldx #_MenuStackc+3
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #1
	bne L64
	ldy #_lastMicSetting
	sty 0,S
	ldd #_MicOnOff+18
	xcall $_strcmp
	cpd #0
	beq L64
	.dbline 479
;    		{	
	.dbline 480
;    			micChanged = true;
	movb #1,_micChanged
	.dbline 481
;    		}	
L64:
	.dbline 483
;    		
;    		strcpy(lastMicSetting, MicOnOff.str_value);
	ldy #_MicOnOff+18
	sty 0,S
	ldd #_lastMicSetting
	jsr _strcpy
	.dbline 485
; 		
; 		if (micChanged && (TC0_RCVD_Data & TeleData_Select))
	ldab _micChanged
	cmpb #0
	beq L69
	ldd _TC0_RCVD_Data
	anda #0
	andb #4
	cpd #0
	beq L69
	.dbline 486
;     	{
	.dbline 487
; 		    if (MicOnOff.value == 1)
	movw _MicOnOff+2,2,-S
	movw _MicOnOff,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr cmpf4
	bne L71
	.dbline 488
; 			    mic_setEnabled(false);
	ldd #0
	xcall $_mic_setEnabled
	bra L72
L71:
	.dbline 490
; 			else
; 			    mic_setEnabled(true);
	ldd #1
	xcall $_mic_setEnabled
L72:
	.dbline 492
; 				
; 			micChanged = false; 
	clr _micChanged
	.dbline 493
; 		}
L69:
	.dbline 496
; 	
;         //Camera message received:
;         if(Gen_Flags & Gen_Flags_SIN0Rcvd)
	brclr _Gen_Flags,#2,L73
	.dbline 497
;         {
	.dbline 501
; 
;     //       SonyCam_HandleInput(Gen_Flags_SIN1Rcvd,Cam_Message);
;              //sendPackets(SIN0Buf,SIN0Bufptr);
;              Cam_HandleInput(Gen_Flags_SIN0Rcvd,Cam_Message);
	ldy #_Cam_Message
	sty 0,S
	ldd #2
	xcall $_Cam_HandleInput
	.dbline 503
;     //       if(Cam_Message[0]!=0) UpdateCam();
;         }
L73:
	.dbline 504
;         if(Gen_Flags & Gen_Flags_SIN0Full)
	brclr _Gen_Flags,#128,L75
	.dbline 505
;         {
	.dbline 507
;     //       SonyCam_HandleInput(Gen_Flags_SIN1Full,Cam_Message);
;              Cam_HandleInput(Gen_Flags_SIN0Full,Cam_Message);
	ldy #_Cam_Message
	sty 0,S
	ldd #128
	xcall $_Cam_HandleInput
	.dbline 508
;         }
L75:
	.dbline 510
; 
;         if(!Titler_Timer && TitlerState && !(Gen_Flags & GEN_FLAGS_MENU_ACTIVE))
	ldy _Titler_Timer
	cpy #0
	lbne L77
	ldab _TitlerState
	cmpb #0
	lbeq L77
	ldab _Gen_Flags
	bitb #8
	lbne L77
	.dbline 511
;     	{
	.dbline 512
;     	    Titler_Timer=37;
	movw #37,_Titler_Timer
	.dbline 513
;     	    for(i=1;i<=3;i++)
	movw #1,_i
	lbra L82
L79:
	.dbline 514
;     	    {
	.dbline 515
;     	        for(j=1;j<=19;j++)
	movw #1,_j
	lbra L86
L83:
	.dbline 516
;     		    {
	.dbline 517
;     		        if(Line_prev[i][j]!=Line[i][j])
	ldd #20
	ldy _i
	emul
	std 14,S
	ldy #_Line
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	std 12,S
	ldd 14,S
	ldx #_Line_prev
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	tfr B,Y
	ldx 12,S
	tfr Y,B
	cmpb 0,X
	beq L87
	.dbline 518
;     			    {
	.dbline 519
;     				    Line_prev[i][j]=Line[i][j];
	ldd #20
	ldy _i
	emul
	std 10,S
	ldy #_Line
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	stab 100,S
	ldd 10,S
	ldx #_Line_prev
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 100,S
	stab 0,Y
	.dbline 520
;     				    OSD_changed=1;
	movb #1,_OSD_changed
	.dbline 521
;     			    }
L87:
	.dbline 522
;     			}
L84:
	.dbline 515
	ldy _j
	iny
	sty _j
L86:
	.dbline 515
	ldy _j
	cpy #19
	lbls L83
	.dbline 523
;     		}
L80:
	.dbline 513
	ldy _i
	iny
	sty _i
L82:
	.dbline 513
	ldy _i
	cpy #3
	lbls L79
	.dbline 524
;     	    if(OSD_changed)
	ldab _OSD_changed
	cmpb #0
	lbeq L89
	.dbline 525
;     	    {
	.dbline 527
;     			char Disp_Line[4][21];
;     			OSD_changed=0;
	clr _OSD_changed
	.dbline 528
;     			Line[0][0]=0;
	clr _Line
	.dbline 529
;     			for (i=0;i<12;i++)
	movw #0,_i
	bra L94
L91:
	.dbline 530
;     			    strcpy(&Menu[i][0], "                    ");
	ldd #21
	ldy #L95
	sty 0,S
	ldy _i
	emul
	tfr D,Y
	ldx #_Menu
	tfr Y,D
	stx 6,S
	addd 6,S
	jsr _strcpy
L92:
	.dbline 529
	ldy _i
	iny
	sty _i
L94:
	.dbline 529
	ldy _i
	cpy #12
	blo L91
	.dbline 531
;     			for(i=0;i<=3;i++)
	movw #0,_i
	lbra L99
L96:
	.dbline 532
;     			{
	.dbline 533
;     			    Disp_Line[i][20]=0;
	ldd #21
	ldy _i
	emul
	tfr D,Y
	leax 37,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 534
;     				for(j=0;j<=19;j++)
	movw #0,_j
	lbra L104
L101:
	.dbline 535
;     				{
	.dbline 536
;     				    if (Line[i][j]==0)
	ldd #20
	ldy _i
	emul
	tfr D,Y
	ldx #_Line
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bne L105
	.dbline 537
;     					    Disp_Line[i][j] = ' ';
	ldd #21
	ldy _i
	emul
	tfr D,Y
	leax 17,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldd #32
	stab 0,Y
	bra L106
L105:
	.dbline 539
;     					else
;     						Disp_Line[i][j] = Line[i][j];
	ldd #20
	ldy _i
	emul
	tfr D,Y
	ldx #_Line
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	tfr B,D
	ldy _i
	stab 16,S
	ldd #21
	emul
	tfr D,Y
	leax 17,S
	tfr Y,D
	stx 6,S
	addd 6,S
	tfr D,Y
	ldd _j
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 16,S
	stab 0,Y
L106:
	.dbline 540
;     				}
L102:
	.dbline 534
	ldy _j
	iny
	sty _j
L104:
	.dbline 534
	ldy _j
	cpy #19
	lbls L101
	.dbline 541
;     				DisplayMultiline(i+1, (char *)&Disp_Line[i], i/3);
	ldx #3
	ldd _i
	idiv
	tfr X,D
	clra
	tfr D,Y
	ldx #21
	sty 2,S
	ldy _i
	tfr X,D
	emul
	tfr D,Y
	leax 17,S
	tfr Y,D
	ldy _i
	iny
	stx 6,S
	addd 6,S
	std 0,S
	tfr Y,D
	xcall $_DisplayMultiline
	.dbline 542
;     			}			
L97:
	.dbline 531
	ldy _i
	iny
	sty _i
L99:
	.dbline 531
	ldy _i
	cpy #3
	lbls L96
	.dbline 543
;     	    }
L89:
	.dbline 544
;     	}
L77:
	.dbline 546
; 
;         if ( gProcImg[OUT_digi_4] == (cam_add & 0x00FF) && gProcImg[OUT_digi_5]<< 8 == (cam_add & 0xFF00) )    //compare
	ldd _cam_add
	anda #0
	andb #-1
	tfr D,Y
	ldab _gProcImg+27
	clra
	tfr D,X
	sty 6,S
	cpx 6,S
	lbne L107
	ldd _cam_add
	anda #-1
	andb #0
	tfr D,Y
	clrb
	ldaa _gProcImg+28
	tfr D,X
	sty 6,S
	cpx 6,S
	lbne L107
	.dbline 547
;     	{
	.dbline 549
;         	char tempstr[18];
; 			int i = 0;
	leax 99,S
	movw #0,0,x
	.dbline 550
;     		gProcImg[OUT_digi_4] = gProcImg[OUT_digi_5] = 0;
	clr _gProcImg+28
	clr _gProcImg+27
	.dbline 551
;     		PORTA |= CAM_ON;       //turn camera on
	bset 0,#4
	.dbline 552
;             set_LED_Level(LEDLevel.value);
	movw _LEDLevel+2,2,-S
	movw _LEDLevel,2,-S
	jsr fp2int
	xcall $_set_LED_Level
	.dbline 553
; 			if (MicOnOff.value == 2)
	movw _MicOnOff+2,2,-S
	movw _MicOnOff,2,-S
	movw #0,2,-S
	movw #16384,2,-S
	jsr cmpf4
	bne L116
	.dbline 554
; 			    mic_setEnabled(true);
	ldd #1
	xcall $_mic_setEnabled
L115:
	.dbline 555
; 			while(CamTag.str_value[i++] == 0x20);
L116:
	.dbline 555
	leay 99,S
	movw 0,y,8,S
	ldy 8,S
	iny
	sty 99,S
	ldd 8,S
	ldy #_CamTag+18
	sty 6,S
	addd 6,S
	tfr D,Y
	ldab 0,Y
	cmpb #32
	beq L115
	.dbline 556
;     		sprintf (tempstr, "Proc:%s", &CamTag.str_value[i-1]); 
	ldd 99,S
	ldy #_CamTag+18-1
	sty 6,S
	addd 6,S
	std 4,S
	ldy #L119
	sty 2,S
	leay 81,S
	sty 0,S
	xcall $_sprintf
	.dbline 557
;     		Display ( tempstr );
	leay 81,S
	tfr Y,D
	xcall $_Display
	.dbline 558
;     	}
	bra L108
L107:
	.dbline 559
;     	else if ( gProcImg[OUT_digi_4] || gProcImg[OUT_digi_5] )
	ldab _gProcImg+27
	cmpb #0
	bne L126
	ldab _gProcImg+28
	cmpb #0
	beq L122
L126:
	.dbline 560
;         {
	.dbline 561
;         	PORTA &= ~CAM_ON;       //turn camera off
	bclr 0,#4
	.dbline 562
; 			mic_setEnabled(false);
	ldd #0
	xcall $_mic_setEnabled
	.dbline 563
;             if(1 == LightAlwaysOnOnOff.value){
	movw _LightAlwaysOnOnOff+2,2,-S
	movw _LightAlwaysOnOnOff,2,-S
	movw #0,2,-S
	movw #16256,2,-S
	jsr cmpf4
	bne L127
	.dbline 563
	.dbline 564
;                 set_LED_Level(0);
	ldd #0
	xcall $_set_LED_Level
	.dbline 565
;             }
L127:
	.dbline 566
;         }
L122:
L108:
	.dbline 568
;     
;         if ( gProcImg[OUT_digi_6] & 0x01 )   //command to generate random address
	brclr _gProcImg+29,#1,L129
	.dbline 569
;         {
	.dbline 570
;             srand(ran_num);               //seed the random number      
	ldd _ran_num
	xcall $_srand
	.dbline 571
;             cam_add = rand();
	xcall $_rand
	tfr D,X
	stx _cam_add
	.dbline 572
;             gProcImg[OUT_digi_6] = 0x00;
	clr _gProcImg+29
	.dbline 573
;             cam_addx[1] = cam_add>>8;
	ldd _cam_add
	tfr A,B
	clra
	stab _cam_addx+1
	.dbline 574
;             cam_addx[0] = cam_add;     
	ldab _cam_add+1
	stab _cam_addx
	.dbline 575
;             Save_Camera_Add();
	xcall $_Save_Camera_Add
	.dbline 576
;         }
L129:
	.dbline 579
;     
;         //command to transmit address + tag
;         if ( gProcImg[OUT_digi_6] & 0x02)   //called by scan_camera in 2-wire
	brclr _gProcImg+29,#2,X4
	bra X5
X4: lbra L134
X5:
	.dbline 580
;         {
	.dbline 581
;             gProcImg[OUT_digi_6] = 0x00;             
	clr _gProcImg+29
	.dbline 584
;     
;             //make delay proportional to camera address so cameras report in ascending order
;             Timer1 = cam_add/100;             
	ldx #100
	ldd _cam_add
	idiv
	stx _Timer1
L138:
	.dbline 585
;             while(Timer1);
L139:
	.dbline 585
	ldy _Timer1
	cpy #0
	bne L138
	.dbline 586
; 			gTxMsg.ID = 0x500;
	movw #1280,_gTxMsg
	.dbline 587
;             gTxMsg.LEN = 8;   
	movb #8,_gTxMsg+2
	.dbline 589
; 			
; 			gTxMsg.BUF[0] = 0x18;           //used to signal camera tag for VID-018
	movb #24,_gTxMsg+4
	.dbline 590
; 			gTxMsg.BUF[1] = cam_add;
	ldab _cam_add+1
	stab _gTxMsg+4+1
	.dbline 591
;             gTxMsg.BUF[2] = cam_add >> 8; 
	ldd _cam_add
	tfr A,B
	clra
	stab _gTxMsg+4+2
	.dbline 592
; 			gTxMsg.BUF[3] = CamTag.str_value[0];
	movb _CamTag+18,_gTxMsg+4+3
	.dbline 593
; 			gTxMsg.BUF[4] = CamTag.str_value[1];
	movb _CamTag+18+1,_gTxMsg+4+4
	.dbline 594
; 			gTxMsg.BUF[5] = CamTag.str_value[2];
	movb _CamTag+18+2,_gTxMsg+4+5
	.dbline 595
; 			gTxMsg.BUF[6] = CamTag.str_value[3];
	movb _CamTag+18+3,_gTxMsg+4+6
	.dbline 596
; 			gTxMsg.BUF[7] = CamTag.str_value[4];
	movb _CamTag+18+4,_gTxMsg+4+7
	.dbline 598
; 			
; 			if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L166
	.dbline 599
;             {
	.dbline 601
;                 // failed to transmit
;                 MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 602
;             }
L166:
	.dbline 604
; 			
; 			gTxMsg.BUF[0] = 0x18;
	movb #24,_gTxMsg+4
	.dbline 605
; 			gTxMsg.BUF[1] = CamTag.str_value[5];
	movb _CamTag+18+5,_gTxMsg+4+1
	.dbline 606
; 			gTxMsg.BUF[2] = CamTag.str_value[6];
	movb _CamTag+18+6,_gTxMsg+4+2
	.dbline 607
; 			gTxMsg.BUF[3] = CamTag.str_value[7];
	movb _CamTag+18+7,_gTxMsg+4+3
	.dbline 608
; 			gTxMsg.BUF[4] = CamTag.str_value[8];
	movb _CamTag+18+8,_gTxMsg+4+4
	.dbline 609
; 			gTxMsg.BUF[5] = CamTag.str_value[9];
	movb _CamTag+18+9,_gTxMsg+4+5
	.dbline 610
; 			gTxMsg.BUF[6] = CamTag.str_value[10];
	movb _CamTag+18+10,_gTxMsg+4+6
	.dbline 611
; 			gTxMsg.BUF[7] = 0x03;
	movb #3,_gTxMsg+4+7
	.dbline 614
; 			
; 			
; 			if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L195
	.dbline 615
;             {
	.dbline 617
;                 // failed to transmit
;                 MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 618
;             }
L195:
	.dbline 619
;         }
L134:
	.dbline 621
;     
;         if ( (gProcImg[OUT_digi_6] & 0x04) &&              //command to store address 
	brclr _gProcImg+29,#4,L197
	ldd _cam_add
	anda #0
	andb #-1
	tfr D,Y
	ldab _gProcImg+30
	clra
	tfr D,X
	sty 6,S
	cpx 6,S
	bne L197
	ldd _cam_add
	anda #-1
	andb #0
	tfr D,Y
	clrb
	ldaa _gProcImg+31
	tfr D,X
	sty 6,S
	cpx 6,S
	bne L197
	.dbline 624
;                 (gProcImg[OUT_digi_7] == (cam_add & 0x00FF)) &&         //lsb - old address
;                     ( (gProcImg[OUT_digi_8]<< 8) ==  (cam_add & 0xFF00)) ) //msb - old address
;         {   //change to new address
	.dbline 625
;             gProcImg[OUT_digi_6] = 0x00;             
	clr _gProcImg+29
	.dbline 626
;             cam_add = gProcImg[OUT_digi_9] + (gProcImg[OUT_digi_10]<<8);
	ldab _gProcImg+33
	tfr B,D
	tfr B,A
	ldab _gProcImg+32
	std _cam_add
	.dbline 628
;             //send new address            
;             cam_addx[0] = cam_add;     
	ldab _cam_add+1
	stab _cam_addx
	.dbline 629
;             cam_addx[1] = cam_add>>8;
	ldd _cam_add
	tfr A,B
	clra
	stab _cam_addx+1
	.dbline 630
;             Save_Camera_Add();
	xcall $_Save_Camera_Add
	.dbline 631
;         }
L197:
	.dbline 633
;         
; 	}   
L47:
	.dbline -2
L6:
	.dbline 0 ; func end
	leas 101,S
	rtc
	.dbsym l tempstr 81 A[18:18]c
	.dbsym l i 99 I
	.dbsym l Disp_Line 17 A[84:4:21]c
	.dbend
	.dbfunc e ATDGetLevel _ATDGetLevel fD
;        ATD_Num -> 1,SP
$_ATDGetLevel::
	pshd
	.dbline -1
	.dbline 639
; 
; }
; 
; 
; float ATDGetLevel ( char ATD_Num )
; {   
	.dbline 640
; 	ATD0CTL5=ATD0CTL5_Init | ATD_Num;
	ldab 1,S
	orab #128
	stab 0x85
L207:
	.dbline 641
;     while (!(ATD0STAT0 & 0x80));
L208:
	.dbline 641
	brclr 0x86,#128,L207
	.dbline 643
; 
;     return (ATD0DR0+ATD0DR1+ATD0DR2+ATD0DR3)/4;
	ldd 0x90
	addd 0x92
	addd 0x94
	addd 0x96
	lsrd
	lsrd
	jsr uint2fp
	.dbline -2
L206:
	.dbline 0 ; func end
	ldd #2
	jmp lret_paged
	.dbsym l ATD_Num 1 c
	.dbend
	.dbfunc e SendSDO _SendSDO fV
;              i -> 2,SP
;            cmd -> 3,SP
;         nBytes -> 18,SP
;          Value -> 13,SP
;       SubIndex -> 12,SP
;          Index -> 9,SP
;         nodeid -> 4,SP
$_SendSDO::
	pshd
	leas -4,S
	.dbline -1
	.dbline 649
;     
; }
; 
; 
; void SendSDO (unsigned int nodeid, unsigned int Index, unsigned char SubIndex, long Value, unsigned char nBytes)
; {
	.dbline 650
;     unsigned char cmd = 0x23, i;
	movb #35,3,S
	.dbline 652
; 	
; 	cmd = cmd | ((4-nBytes)<<2);
	ldab 18,S
	clra
	tfr D,Y
	ldd #4
	sty 0,S
	subd 0,S
	lsld
	lsld
	tfr D,Y
	ldab 3,S
	clra
	sty 0,S
	ora 0,S
	orb 1,S
	stab 3,S
	.dbline 655
; 	
; 
;     gTxMsg.ID = nodeid;
	movw 4,S,_gTxMsg
	.dbline 656
;     gTxMsg.LEN = 8;
	movb #8,_gTxMsg+2
	.dbline 657
;     gTxMsg.BUF[0] = cmd;
	movb 3,S,_gTxMsg+4
	.dbline 658
;     gTxMsg.BUF[1] = Index & 0xff;
	ldd 9,S
	anda #0
	andb #-1
	stab _gTxMsg+4+1
	.dbline 659
;     gTxMsg.BUF[2] = Index>>8 & 0xff;
	ldd 9,S
	tfr A,B
	clra
	anda #0
	andb #-1
	stab _gTxMsg+4+2
	.dbline 660
;     gTxMsg.BUF[3] = SubIndex;
	movb 12,S,_gTxMsg+4+3
	.dbline 661
;     gTxMsg.BUF[4] = Value & 0xff;
	ldd 15,S
	pshd
	ldd 15,S
	pshd
	movw #255,2,-S
	movw #0,2,-S
	jsr and4
	leas 2,S
	puly
	tfr Y,B
	stab _gTxMsg+4+4
	.dbline 662
;     gTxMsg.BUF[5] = Value>>8 & 0xff;
	ldd 15,S
	pshd
	ldd 15,S
	pshd
	ldd #8
	jsr asr4
	movw #255,2,-S
	movw #0,2,-S
	jsr and4
	leas 2,S
	puly
	tfr Y,B
	stab _gTxMsg+4+5
	.dbline 663
;     gTxMsg.BUF[6] = Value>>16 & 0xff;
	ldd 15,S
	pshd
	ldd 15,S
	pshd
	ldd #16
	jsr asr4
	movw #255,2,-S
	movw #0,2,-S
	jsr and4
	leas 2,S
	puly
	tfr Y,B
	stab _gTxMsg+4+6
	.dbline 664
;     gTxMsg.BUF[7] = Value>>24 & 0xff;
	ldd 15,S
	pshd
	ldd 15,S
	pshd
	ldd #24
	jsr asr4
	movw #255,2,-S
	movw #0,2,-S
	jsr and4
	leas 2,S
	puly
	tfr Y,B
	stab _gTxMsg+4+7
	.dbline 665
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L227
	.dbline 666
;     {
	.dbline 668
;         // failed to transmit
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 669
;     }
L227:
	.dbline 670
; 	i = MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	stab 2,S
	.dbline -2
L210:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l i 2 c
	.dbsym l cmd 3 c
	.dbsym l nBytes 18 c
	.dbsym l Value 13 L
	.dbsym l SubIndex 12 c
	.dbsym l Index 9 i
	.dbsym l nodeid 4 i
	.dbend
	.dbfunc e SendTPDO _SendTPDO fV
;           buf7 -> 22,SP
;           buf6 -> 20,SP
;           buf5 -> 18,SP
;           buf4 -> 16,SP
;           buf3 -> 14,SP
;           buf2 -> 12,SP
;           buf1 -> 10,SP
;           buf0 -> 8,SP
;            len -> 6,SP
;         nodeid -> 0,SP
$_SendTPDO::
	pshd
	.dbline -1
	.dbline 674
; }
; 
; void SendTPDO (unsigned int nodeid, char len, char buf0, char buf1, char buf2, char buf3, char buf4, char buf5, char buf6, char buf7)
; {
	.dbline 676
; 
;     gTxMsg.ID = nodeid;
	movw 0,S,_gTxMsg
	.dbline 677
;     gTxMsg.LEN = len;
	movb 6,S,_gTxMsg+2
	.dbline 678
;     gTxMsg.BUF[0] = buf0;
	movb 8,S,_gTxMsg+4
	.dbline 679
;     gTxMsg.BUF[1] = buf1;
	movb 10,S,_gTxMsg+4+1
	.dbline 680
;     gTxMsg.BUF[2] = buf2;
	movb 12,S,_gTxMsg+4+2
	.dbline 681
;     gTxMsg.BUF[3] = buf3;
	movb 14,S,_gTxMsg+4+3
	.dbline 682
;     gTxMsg.BUF[4] = buf4;
	leax 16,S
	movb 0,x,_gTxMsg+4+4
	.dbline 683
;     gTxMsg.BUF[5] = buf5;
	leax 18,S
	movb 0,x,_gTxMsg+4+5
	.dbline 684
;     gTxMsg.BUF[6] = buf6;
	leax 20,S
	movb 0,x,_gTxMsg+4+6
	.dbline 685
;     gTxMsg.BUF[7] = buf7;
	leax 22,S
	movb 0,x,_gTxMsg+4+7
	.dbline 686
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L246
	.dbline 687
;     {
	.dbline 689
;         // failed to transmit
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 690
;     }
L246:
	.dbline 691
; 	MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	.dbline -2
L229:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l buf7 22 c
	.dbsym l buf6 20 c
	.dbsym l buf5 18 c
	.dbsym l buf4 16 c
	.dbsym l buf3 14 c
	.dbsym l buf2 12 c
	.dbsym l buf1 10 c
	.dbsym l buf0 8 c
	.dbsym l len 6 c
	.dbsym l nodeid 0 i
	.dbend
	.dbfunc e SendNMT _SendNMT fV
;              i -> 0,SP
;           node -> 7,SP
;            cmd -> 2,SP
$_SendNMT::
	pshd
	leas -1,S
	.dbline -1
	.dbline 696
; }
; 
; 
; void SendNMT (unsigned char cmd, unsigned char node)
; {
	.dbline 705
; // 0x01	Go to 'operational'
; // 0x02	Go to 'stopped'
; // 0x80	Go to 'pre-operational'
; // 0x81	Go to 'reset node'
; // 0x82	Go to 'reset communication'
;     
; 	unsigned char i;
; 	
;     gTxMsg.ID = 0x000;
	movw #0,_gTxMsg
	.dbline 706
;     gTxMsg.LEN = 2;
	movb #2,_gTxMsg+2
	.dbline 707
;     gTxMsg.BUF[0] = cmd;
	movb 2,S,_gTxMsg+4
	.dbline 708
;     gTxMsg.BUF[1] = node;
	movb 7,S,_gTxMsg+4+1
	.dbline 710
; 
;     if (!MCOHW_PushMessage(&gTxMsg))
	ldd #_gTxMsg
	xcall $_MCOHW_PushMessage
	clra
	cmpb #0
	bne L253
	.dbline 711
;     {
	.dbline 713
;         // failed to transmit
;         MCOUSER_FatalError(0x8801);
	ldd #34817
	xcall $_MCOUSER_FatalError
	.dbline 714
;     }
L253:
	.dbline 715
; 	i = MCO_ProcessStack();
	xcall $_MCO_ProcessStack
	stab 0,S
	.dbline -2
L248:
	.dbline 0 ; func end
	leas 3,S
	rtc
	.dbsym l i 0 c
	.dbsym l node 7 c
	.dbsym l cmd 2 c
	.dbend
	.dbfunc e sout _sout fV
;        soutstr -> 9,SP
;     SerialPort -> 4,SP
$_sout::
	pshd
	leas -4,S
	.dbline -1
	.dbline 719
; }
; 
; void sout (int SerialPort, char soutstr[])
; {
	.dbline 720
;     if (SerialPort == 0)
	ldy 4,S
	cpy #0
	lbne L256
	.dbline 721
; 	{
L258:
	.dbline 722
; 	    while ( Gen_Flags & Gen_Flags_Xmt0 );
L259:
	.dbline 722
	ldab _Gen_Flags
	bitb #64
	bne L258
	.dbline 723
; 		SOUT0Bufptr = 0;
	movw #0,_SOUT0Bufptr
	bra L262
L261:
	.dbline 725
; 		while ( soutstr[SOUT0Bufptr] != '\0' )
; 			 SOUT0Buf[SOUT0Bufptr] = soutstr[SOUT0Bufptr++];
	movw _SOUT0Bufptr,2,S
	ldd 2,S
	ldy 2,S
	iny
	sty _SOUT0Bufptr
	ldy #_SOUT0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd 2,S
	addd 9,S
	tfr D,X
	ldab 0,X
	stab 0,Y
L262:
	.dbline 724
	ldd _SOUT0Bufptr
	addd 9,S
	tfr D,Y
	ldab 0,Y
	cmpb #0
	bne L261
	.dbline 726
; 		SOUT0Buf[SOUT0Bufptr] = 0;
	ldd _SOUT0Bufptr
	ldy #_SOUT0Buf
	sty 0,S
	addd 0,S
	tfr D,Y
	ldd #0
	stab 0,Y
	.dbline 727
; 		SOUT0Bufptr = 0;
	movw #0,_SOUT0Bufptr
	.dbline 728
; 		Gen_Flags |= Gen_Flags_Xmt0;
	bset _Gen_Flags,#64
	.dbline 729
; 		SCI0CR2 |= SCI0CR2_TIE;
	bset 0xcb,#128
	.dbline 730
; 	}
L256:
	.dbline -2
L255:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l soutstr 9 pc
	.dbsym l SerialPort 4 I
	.dbend
	.dbfunc e Load_Camera_Add _Load_Camera_Add fV
; VarEEPROMPntr2 -> 0,SP
$_Load_Camera_Add::
	leas -2,S
	.dbline -1
	.dbline 736
; 
; }
; 
; //retreive camera address from EEProm
; void Load_Camera_Add ( void )
; {
	.dbline 738
;     char *VarEEPROMPntr2;
;     VarEEPROMPntr2 = (char *)0x0900;
	movw #2304,0,S
	.dbline 740
;     
;     cam_addx[0] = *VarEEPROMPntr2;
	ldy 0,S
	movb 0,Y,_cam_addx
	.dbline 741
;     cam_addx[1] = *(VarEEPROMPntr2 + 1);   
	ldy 0,S
	iny
	movb 0,Y,_cam_addx+1
	.dbline 742
;     cam_add = cam_addx[0] + (cam_addx[1]<<8);               
	ldab _cam_addx+1
	tfr B,D
	tfr B,A
	ldab _cam_addx
	std _cam_add
	.dbline -2
L264:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l VarEEPROMPntr2 0 pc
	.dbend
	.dbfunc e Save_Camera_Add _Save_Camera_Add fV
;      EEpromPtr -> 4,SP
$_Save_Camera_Add::
	leas -6,S
	.dbline -1
	.dbline 746
; }
; 
; void Save_Camera_Add ( void )
; {
	.dbline 749
;     char *EEpromPtr;
;     
;     EEpromPtr = &cam_addx[0];
	ldy #_cam_addx
	sty 4,S
	.dbline 751
; 
;  	EEWrite ( 2, EEpromPtr, (int *)0x0900 );
	ldy #2304
	sty 2,S
	ldy 4,S
	sty 0,S
	ldd #2
	xcall $_EEWrite
	.dbline -2
L267:
	.dbline 0 ; func end
	leas 6,S
	rtc
	.dbsym l EEpromPtr 4 pc
	.dbend
	.dbfunc e mic_setEnabled _mic_setEnabled fV
;            val -> 1,SP
$_mic_setEnabled::
	pshd
	.dbline -1
	.dbline 755
; }
; 
; void mic_setEnabled(bool val)
; {
	.dbline 756
;     if (val == true)
	ldab 1,S
	cmpb #1
	bne L269
	.dbline 757
; 	    PORTA |= MIC_SHDN;   //turn mic on
	bset 0,#2
	bra L270
L269:
	.dbline 759
; 	else	
; 	    PORTA &= ~MIC_SHDN;  //turn mic off  
	bclr 0,#2
L270:
	.dbline -2
L268:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l val 1 c
	.dbend
	.dbfunc e set_LED_Level _set_LED_Level fV
;            val -> 0,SP
$_set_LED_Level::
	pshd
	.dbline -1
	.dbline 765
; 
; }
; 
; /// @brief Sets the output level by selecting which FETs are on
; /// @param val int between 0-8, 0 being low off 8 is full on
; void set_LED_Level(int val){
	.dbline 766
;     switch (val)
	ldy 0,S
	cpy #1
	lbeq L282
	ldy 0,S
	cpy #2
	lbeq L281
	ldy 0,S
	cpy #3
	lbeq L280
	ldy 0,S
	cpy #4
	lbeq L279
	ldy 0,S
	cpy #5
	lbeq L278
	ldy 0,S
	cpy #6
	beq L277
	ldy 0,S
	cpy #7
	beq L276
	ldy 0,S
	cpy #8
	beq L275
	ldy 0,S
	cpy #9
	beq L274
	lbra L272
L274:
	.dbline 770
;     {
;     case 9:
;         //LED Full Level
;         PORTA |= LED_ON;
	bset 0,#32
	.dbline 771
;         PORTA &= ~LED_R1;
	bclr 0,#16
	.dbline 772
;         PORTA &= ~LED_R2;
	bclr 0,#64
	.dbline 773
;         PORTA &= ~LED_R3;
	bclr 0,#128
	.dbline 774
;         break;
	lbra L273
L275:
	.dbline 777
;     case 8:
;         //LED Level 7
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 778
;         PORTA |= LED_R1;
	bset 0,#16
	.dbline 779
;         PORTA |= LED_R2;
	bset 0,#64
	.dbline 780
;         PORTA |= LED_R3;
	bset 0,#128
	.dbline 781
;         break;
	lbra L273
L276:
	.dbline 784
;     case 7:
;         //LED Level 6
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 785
;         PORTA |= LED_R1;
	bset 0,#16
	.dbline 786
;         PORTA |= LED_R2;
	bset 0,#64
	.dbline 787
;         PORTA &= ~LED_R3;
	bclr 0,#128
	.dbline 788
;         break;
	lbra L273
L277:
	.dbline 791
;     case 6:
;         //LED Level 5
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 792
;         PORTA |= LED_R1;
	bset 0,#16
	.dbline 793
;         PORTA &= ~LED_R2;
	bclr 0,#64
	.dbline 794
;         PORTA |= LED_R3;
	bset 0,#128
	.dbline 795
;         break;
	bra L273
L278:
	.dbline 798
;     case 5:
;         //LED Level 4
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 799
;         PORTA |= LED_R1;
	bset 0,#16
	.dbline 800
;         PORTA &= ~LED_R2;
	bclr 0,#64
	.dbline 801
;         PORTA &= ~LED_R3;
	bclr 0,#128
	.dbline 802
;         break;
	bra L273
L279:
	.dbline 805
;     case 4:
;         //LED Level 3
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 806
;         PORTA &= ~LED_R1;
	bclr 0,#16
	.dbline 807
;         PORTA |= LED_R2;
	bset 0,#64
	.dbline 808
;         PORTA |= LED_R3;
	bset 0,#128
	.dbline 809
;         break;
	bra L273
L280:
	.dbline 812
;     case 3:
;         //LED Level 2
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 813
;         PORTA &= ~LED_R1;
	bclr 0,#16
	.dbline 814
;         PORTA |= LED_R2;
	bset 0,#64
	.dbline 815
;         PORTA &= ~LED_R3;
	bclr 0,#128
	.dbline 816
;         break;
	bra L273
L281:
	.dbline 819
;     case 2:
;         //LED Level 1
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 820
;         PORTA &= ~LED_R1;
	bclr 0,#16
	.dbline 821
;         PORTA &= ~LED_R2;
	bclr 0,#64
	.dbline 822
;         PORTA |= LED_R3;
	bset 0,#128
	.dbline 823
;         break;
	bra L273
L282:
L272:
	.dbline 827
;     case 1:
;     default:
;         //LED OFF
;         PORTA &= ~LED_ON;
	bclr 0,#32
	.dbline 828
;         PORTA &= ~LED_R1;
	bclr 0,#16
	.dbline 829
;         PORTA &= ~LED_R2;
	bclr 0,#64
	.dbline 830
;         PORTA &= ~LED_R3;
	bclr 0,#128
	.dbline 831
;         break;
L273:
	.dbline -2
L271:
	.dbline 0 ; func end
	leas 2,S
	rtc
	.dbsym l val 0 I
	.dbend
	.area bss
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
_TitlerState::
	.blkb 1
	.dbsym e TitlerState _TitlerState c
_Menu::
	.blkb 252
	.dbsym e Menu _Menu A[252:12:21]c
_cam_addx::
	.blkb 2
	.dbsym e cam_addx _cam_addx A[2:2]c
_lastResSetting::
	.blkb 5
	.dbsym e lastResSetting _lastResSetting A[5:5]c
_lastMicSetting::
	.blkb 5
	.dbsym e lastMicSetting _lastMicSetting A[5:5]c
_cam_add::
	.blkb 2
	.dbsym e cam_add _cam_add i
_Line::
	.blkb 80
	.dbsym e Line _Line A[80:4:20]c
_OSD_changed::
	.blkb 1
	.dbsym e OSD_changed _OSD_changed c
_Cam_Message::
	.blkb 9
	.dbsym e Cam_Message _Cam_Message A[9:9]c
_CANBuf::
	.blkb 15
	.dbsym e CANBuf _CANBuf A[15:15]c
_UpdateMenu::
	.blkb 1
	.dbsym e UpdateMenu _UpdateMenu c
_gTxMsg::
	.blkb 12
	.dbstruct 0 12 .2
	.dbfield 0 ID i
	.dbfield 2 LEN c
	.dbfield 3 dummy32bit c
	.dbfield 4 BUF A[8:8]c
	.dbend
	.dbsym e gTxMsg _gTxMsg S[.2]
_Line_prev::
	.blkb 80
	.dbsym e Line_prev _Line_prev A[80:4:20]c
_k::
	.blkb 2
	.dbsym e k _k i
_j::
	.blkb 2
	.dbsym e j _j i
_i::
	.blkb 2
	.dbsym e i _i i
	.area text
	.dbfile C:\Dev\REV1~1.01\Subroutines.c
L119:
	.byte 'P,'r,'o,'c,58,37,'s,0
L95:
	.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	.byte 32,32,32,32,0
L50:
	.byte 37,48,52,'X,0
L36:
	.byte 32,'P,'O,'S,'I,'T,'I,'O,'N,32,'A,'C,'T,'I,'V,'E
	.byte 32,32,32,32,0
L33:
	.byte 129,1,'p,1,39,255,0
