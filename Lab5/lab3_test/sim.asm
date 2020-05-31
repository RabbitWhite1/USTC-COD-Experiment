# 初始PC = 0x00000000

.data
    .word 0,6,0,8,0x80000000,0x80000100,0x100,5,0
                   ;
_start:    
		addi $t0,$0,3       	#t0=3   0  20080003
        addi $t1,$0,5   		#t1=5	4  20090005
		addi $t2,$0,1       	#t2=1	8  200a0001
		addi $t3,$0,0			#t3=0	12  200b0000

        add  $s0,$t1,$t0  		#s0=t1+t0=8  测试add指令	16	01288020
        lw   $s1,12($0)  		#							20	8c11000c
        beq  $s1,$s0,_next1		#正确跳到_next 				24	12300001
		
		j _fail						# 08000010

_next1:	
		lw $t0, 16($0)			#t0 = 0x80000000	32	8c080010
		lw $t1, 20($0)			#t1 = 0x80000100	36	8c090014
		
		add  $s0,$t1,$t0		#s0 = 0x00000100 = 256	40	01288020
		lw $s1, 24($0)			#						44	8c110018
        beq  $s1,$s0,_next2		#正确跳到_success		48	12300001
		
		j _fail					# 08000010

_next2:
		add $0, $0, $t2			# $0应该为0			56 	000a0020
		beq $0,$t3,_success		#				    60	100b0002
		
		
_fail:  
		sw   $t3,8($0) 	# ac0b0008	64
        j    _fail		# 08000010	68

_success: 
		sw   $t2,8($0)		#全部测试通过，存储器地址0x08里的值为1	ac0a0008	72
		j   _success 		#08000012	76

					  		#判断测试通过的条件是最后存储器地址0x08里的值为1，说明全部通过测试