.data 

getValuesMessage:  .asciiz "Enter the number of iteration for the series: "
space:             .asciiz   " "
aSpace:		   .space  1024 


.text

main:
	li $v0, 4
	la $a0, getValuesMessage
	syscall
	
	li $v0, 5
	syscall
	
	# iteration number
	move $s2, $v0
	# initalize varibales t0 = a, t1=b
	addi $s0, $zero, 1
	addi $s1, $zero, 1
	
	li $v0, 1
	move $a0, $s0
	# print the s1
	syscall
	
	li $v0, 1
	move $a0, $s1
	# print the s2
	syscall
	
loop: 
	# check the loop count if it is zero go main address, if is not continue
	beq $zero, $s2, main
	
	move $t0, $s0
	move $t1, $s1
	
	# 2b -> t2
	add $t2, $t1, $t1
	# a+2b -> t2 it means that it is a2
	add $t2, $t2, $t0
	li $v0, 1
	move $a0, $t2
	# print the a2
	syscall
	
	j loop
	
		

	
	
	
	
	
	
