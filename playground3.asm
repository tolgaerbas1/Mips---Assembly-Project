.data


buffer:			.space 1024
firstMatrixBuffer: 	.space 1024
secondMatrixBuffer: 	.space 1024
firstDimensionBuffer: 	.space 10
secondDimensionBuffer:	.space 10

# Matrix array buffer
# It should be 4 times buffer size because the we will convert every bytes to 32 bit integer values
# so we need the 4 byte for each byte of have been entered input.
matrixArraySize: 	.space 4096 

enterStr:		.asciiz "Please enter a string: "
indexChar:      	.asciiz "Please enter the index of char to print: "
newLine:		.asciiz "\n"
enterFirstMatrix:	.asciiz "Enter the first matrix: "
enterSecondMatrix:	.asciiz "Enter the second matrix: "
enterFirstDimensionFM:	.asciiz "Enter the first dimension of first matrix: "
enterSecondDimensionFM:	.asciiz "Enter the first dimension of first matrix: "
multiplicationMatrix:	.asciiz "Multiplication Matrix: "

### print 
# string 4
# integer 1
# byte 11

### input
# string 8
# integer 5



.text
	j q2	
q2:
	
	j getFirstMatrixAsString
	j getSecondMatrixAsString
	j getFirstDimensionFMAsString
	j getSecondDimensionFMAsString
	j parse
	
	#li $v0, 11
	#lb $t1, 1($t0) # t0 holds the start address of the input
	#la $a0, ($t1) 
	#syscall
	
	#add $t2, $t1, $zero # to extend the byte to integer (8 bit to 32 bit with signed) use add.
	#li $v0, 1
	#la $a0, ($t2)
	#syscall
	
	# end of the main** remove this to merge questions * * *
	
	
getFirstMatrixAsString: # starting address in $s0

	# print enter the first matrix
	li $v0, 4
	la $a0, enterFirstMatrix
	syscall
	
	# get the first matrix
	li $v0, 8
	la $a0, firstMatrixBuffer
	la $s0, ($a0) # $s0 contains the starting byte address of first matrix string**  
	la $a1, 1024
	syscall
	
getSecondMatrixAsString: # starting address in $s1

	# print enter the second matrix
	li $v0, 4
	la $a0, enterSecondMatrix
	syscall
	
	# get the second matrix
	li $v0, 8
	la $a0, secondMatrixBuffer
	la $s1, ($a0) # $s1 contains the starting byte address of second matrix string**  
	la $a1, 1024
	syscall
	
getFirstDimensionFMAsString:
	
	# print enter the first dimension
	li $v0, 4
	la $a0, enterFirstDimensionFM
	syscall
	
	# get the first dimension of first matrix
	li $v0, 8
	la $a0, firstDimensionBuffer
	la $s2, ($a0) # $s2 contains the starting byte address of first dimension string**  
	la $a1, 1024
	syscall
	

getSecondDimensionFMAsString:
	
	# print enter the second dimension
	li $v0, 4
	la $a0, enterSecondDimensionFM
	syscall
	
	# get the second dimension of first matrix
	li $v0, 8
	la $a0, secondDimensionBuffer
	la $s3, ($a0) # $s3 contains the starting byte address of second dimension string**  
	la $a1, 1024
	syscall
	 
parse:
	
	# prints to check inputs are correct 	
	
	li $v0, 4
	move $a0, $s0
	syscall
	
	li $v0, 4
	move $a0, $s1
	syscall
	
	li $v0, 4
	move $a0, $s2
	syscall
	
	li $v0, 4
	move $a0, $s3
	syscall
	
	li $v0, 10
	syscall
	
