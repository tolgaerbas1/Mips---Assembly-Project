.data


buffer:			.space 1024
firstMatrixBuffer: 	.space 1024
secondMatrixBuffer: 	.space 1024
firstDimensionBuffer: 	.space 10
secondDimensionBuffer:	.space 10

# Matrix array buffer
# It should be 4 times buffer size because the we will convert every bytes to 32 bit integer values
# so we need the 4 byte for each byte of have been entered input.
firstMatrixArrayBuffer: .space 4096 
secondMatrixArrayBuffer: .space 4096 

enterStr:		.asciiz "Please enter a string: "
indexChar:      	.asciiz "Please enter the index of char to print: "
newLine:		.asciiz "\n"
spaceChar: 		.asciiz " "
enterFirstMatrix:	.asciiz "Enter the first matrix: "
enterSecondMatrix:	.asciiz "Enter the second matrix: "
enterFirstDimensionFM:	.asciiz "Enter the first dimension of first matrix: "
enterSecondDimensionFM:	.asciiz "Enter the second dimension of first matrix: "
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
	la $a1, 10
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
	la $a1, 10
	syscall
	 
parse:
	
	# prints to check inputs are correct 	
	addi $s4, $zero, -1  # s4 contains the loop counter
	addi $s5, $zero, 0
	j firstMatrixParseLoop
	

firstMatrixParseLoop:
	
	# get the char from incremented address
	addi $s4, $s4, 1
	add $t0, $s4, $s0
	lb $t1, 0($t0) # $ now t1 contains the value 
	lb $t2, spaceChar # get the space char byte to compare with in char at $t0
	beq $t1, $t2, firstMatrixParseLoop
	add $t1, $zero, $t1 # $t1 contains the ascii code of character as integer  
	addi $t2, $zero, 10
	beq $t1, $t2, secondMatrixParseLoop   
	addi $t1, $t1, -48 # to convert number ascii code to 4 byte integer value 
	addi $s5, $s5, 1
	add $t1, $zero, $t1
	addi $t5, $zero, 4
	mul $t5, $s5, $t5
	la $t6, firstArrayMatrixBuffer
	add $t5, $t6, $t5
	
	    
	sw $t1, 0($t5)
	
	#add $t1, $zero, $a0
	#addi $t1, $t1, -48 
	li $v0, 1
	move $a0, $t1
	#move $a0, $t1


getAllIntegerValue:
	
	

	addi $a0, $a0, -4
	lw $t7, 0($a0)
	addi $t3, $zero, 10
	mul $t7, $t7, $t3
	add $t7, $t7, $a1
	sw $t7, 0($a0)
	j incrementInteger
	
incrementIntegerArrayCounter:
	
	addi $s5, 4
	j firstMatrixParseLoop	


secondMatrixParseLoop:
	
	
	
	

setAddressForSecondMatrix:
	
	move $s0, $zero
	add $s0, $zero, $s1 # set $s0 to $s1's value
	addi $s4, $zero, -1 # set counter -1 again
	j parseLoop
