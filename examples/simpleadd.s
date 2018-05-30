# start of generated code
	.data
	.align	2
	.globl	class_nameTab
	.globl	Main_protObj
	.globl	Int_protObj
	.globl	String_protObj
	.globl	bool_const0
	.globl	bool_const1
	.globl	_int_tag
	.globl	_bool_tag
	.globl	_string_tag
_int_tag:
	.word	4
_bool_tag:
	.word	5
_string_tag:
	.word	3
	.globl	_MemMgr_INITIALIZER
_MemMgr_INITIALIZER:
	.word	_NoGC_Init
	.globl	_MemMgr_COLLECTOR
_MemMgr_COLLECTOR:
	.word	_NoGC_Collect
	.globl	_MemMgr_TEST
_MemMgr_TEST:
	.word	0
	.word	-1
str_const11:
	.word	3
	.word	5
	.word	
	.word	int_const1
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	3
	.word	6
	.word	
	.word	int_const2
	.ascii	"Main"
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	3
	.word	6
	.word	
	.word	int_const3
	.ascii	"String"
	.byte	0	
	.align	2
	.word	-1
str_const8:
	.word	3
	.word	6
	.word	
	.word	int_const2
	.ascii	"Bool"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	3
	.word	5
	.word	
	.word	int_const4
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const6:
	.word	3
	.word	5
	.word	
	.word	int_const5
	.ascii	"IO"
	.byte	0	
	.align	2
	.word	-1
str_const5:
	.word	3
	.word	6
	.word	
	.word	int_const3
	.ascii	"Object"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	3
	.word	7
	.word	
	.word	int_const0
	.ascii	"_prim_slot"
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	3
	.word	7
	.word	
	.word	int_const6
	.ascii	"SELF_TYPE"
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	3
	.word	7
	.word	
	.word	int_const6
	.ascii	"_no_class"
	.byte	0	
	.align	2
	.word	-1
str_const1:
	.word	3
	.word	8
	.word	
	.word	int_const7
	.ascii	"<basic class>"
	.byte	0	
	.align	2
	.word	-1
str_const0:
	.word	3
	.word	10
	.word	
	.word	int_const8
	.ascii	"examples/simpleadd.cl"
	.byte	0	
	.align	2
	.word	-1
int_const8:
	.word	4
	.word	4
	.word	
	.word	21
	.word	-1
int_const7:
	.word	4
	.word	4
	.word	
	.word	13
	.word	-1
int_const6:
	.word	4
	.word	4
	.word	
	.word	9
	.word	-1
int_const5:
	.word	4
	.word	4
	.word	
	.word	2
	.word	-1
int_const4:
	.word	4
	.word	4
	.word	
	.word	3
	.word	-1
int_const3:
	.word	4
	.word	4
	.word	
	.word	6
	.word	-1
int_const2:
	.word	4
	.word	4
	.word	
	.word	4
	.word	-1
int_const1:
	.word	4
	.word	4
	.word	
	.word	0
	.word	-1
int_const0:
	.word	4
	.word	4
	.word	
	.word	10
	.word	-1
bool_const0:
	.word	5
	.word	4
	.word	
	.word	0
	.word	-1
bool_const1:
	.word	5
	.word	4
	.word	
	.word	1
class_nameTab:
	.word	str_const5
	.word	str_const6
	.word	str_const7
	.word	str_const8
	.word	str_const9
	.word	str_const10

class_objTab:
	.word	Object_protObj
	.word	Object_init
	.word	IO_protObj
	.word	IO_init
	.word	Int_protObj
	.word	Int_init
	.word	Bool_protObj
	.word	Bool_init
	.word	String_protObj
	.word	String_init
	.word	Main_protObj
	.word	Main_init

Object_dispTab
	.word	abort
str_const5	.word	type_name
str_const5	.word	copy
str_const5IO_dispTab
	.word	out_string
str_const6	.word	out_int
str_const6	.word	in_string
str_const6	.word	in_int
str_const6	.word	abort
str_const6	.word	type_name
str_const6	.word	copy
str_const6Int_dispTab
	.word	abort
str_const7	.word	type_name
str_const7	.word	copy
str_const7Bool_dispTab
	.word	abort
str_const8	.word	type_name
str_const8	.word	copy
str_const8String_dispTab
	.word	length
str_const9	.word	concat
str_const9	.word	substr
str_const9	.word	abort
str_const9	.word	type_name
str_const9	.word	copy
str_const9Main_dispTab
	.word	main
str_const10	.word	out_string
str_const10	.word	out_int
str_const10	.word	in_string
str_const10	.word	in_int
str_const10	.word	abort
str_const10	.word	type_name
str_const10	.word	copy
str_const10
	.word	-1
Object_protObj:

	.word	5
	.word	3
	.word	Object_dispTab
str_const5	.word	-1
IO_protObj:

	.word	6
	.word	3
	.word	IO_dispTab
str_const6	.word	-1
Int_protObj:

	.word	4
	.word	4
	.word	Int_dispTab
str_const7	.word	-1
Bool_protObj:

	.word	5
	.word	4
	.word	Bool_dispTab
str_const8	.word	-1
String_protObj:

	.word	3
	.word	5
	.word	String_dispTab
str_const9	.word	-1
Main_protObj:

	.word	7
	.word	4
	.word	Main_dispTab
str_const10	.globl	heap_start
heap_start:
	.word	0
	.text
	.globl	Main_init
	.globl	Int_init
	.globl	String_init
	.globl	Bool_init
	.globl	Main.main
	la	$a0 int_const0
