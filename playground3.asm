.data


buffer:			.space 1024
firstMatrixBuffer: 	.space 1024
secondMatrixBuffer: 	.space 1024
firstDimensionBuffer: 	.space 10
secondDimensionBuffer:	.space 10

# Matrix array buffer
# It should be 4 times buffer size because the we will convert every bytes to 32 bit integer values
# so we need the 4 byte for each byte of have been entered integer input.
firstMatrixArray: 	.space 2048 
secondMatrixArray:	.space 2048
firstDimension:		.space 4
secondDimension: 	.space 4
secondMatrixLength:	.space 4
secondMatrixCol: 	.space 4
productMatrixArray:	.space 2048


enterStr:		.asciiz "Please enter a string: "
indexChar:      	.asciiz "Please enter the index of char to print: "
newLine:		.asciiz "\n"
spaceChar: 		.asciiz " "
enterFirstMatrix:	.asciiz "Enter the first matrix: "
enterSecondMatrix:	.asciiz "Enter the second matrix: "
enterFirstDimensionFM:	.asciiz "Enter the first dimension of first matrix: "
enterSecondDimensionFM:	.asciiz "Enter the second dimension of first matrix: "
multiplicationMatrix:	.asciiz "Multiplication Matrix: "

# log strings
inSetZero:		.asciiz "In Set Zero !\n"
inUpdateValue:		.asciiz "In Update Value !\n"

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
	
	jal getFirstMatrixAsString
	jal getSecondMatrixAsString
	jal getFirstDimensionFMAsString
	jal getSecondDimensionFMAsString
	
	la $a0, firstMatrixBuffer
	la $a1, firstMatrixArray
	jal parseMatrix
	
	la $a0, secondMatrixBuffer
	la $a1, secondMatrixArray
	jal parseMatrix

	jal setSecondMatrixLength
	
	la $a0, firstDimensionBuffer
	la $a1, firstDimension
	jal parseMatrix
	
	la $a0, secondDimensionBuffer
	la $a1, secondDimension
	jal parseMatrix
	
	
	#jal setDimensions
	
	#jal printArrays

	li $v0, 10
	syscall

setSecondMatrixLength:

	la $t1, secondMatrixArray
	sub $t1, $s2, $t1 # t1 contains the s2 address - secondMatrixArray address = ( lengthOfArray ) * 4
	sra $t1, $t1, 2 # s2 contains the last index of matrix array which is empty. We divided by 4 beacuse the to get the length of array. (total size = size * 4 )
	
	la $t2, secondMatrixLength
	sw $t1, 0($t2)
	
	move $a0, $t2
	li $v0, 1
	syscall
	
setDimensions:

	
	la $t1, secondDimension
	lw $t1, 0($t1)
	
	la $t2, secondMatrixLength
	lw $t2, 0($t2) 
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	move $a0, $t2
	syscall
	
	
	#div $t1, $t2, $t1 # s2 contains the second matrix column length now.
	#la $t1, secondMatrixCol
	#sw $s2, 0($t1)
	#lw $a0, 0($t1)
	
	
getFirstMatrixAsString:

	# print enter the first matrix
	li $v0, 4
	la $a0, enterFirstMatrix
	syscall
	
	
	# get the first matrix
	li $v0, 8
	la $a0, firstMatrixBuffer
	la $a1, 1024
	syscall
	
	jr $ra
	
getSecondMatrixAsString:

	# print enter the second matrix
	li $v0, 4
	la $a0, enterSecondMatrix
	syscall
	
	# get the second matrix
	li $v0, 8
	la $a0, secondMatrixBuffer 
	la $a1, 1024
	syscall
	
	jr $ra
	
getFirstDimensionFMAsString:
	
	# print enter the first dimension
	li $v0, 4
	la $a0, enterFirstDimensionFM
	syscall
	
	# get the first dimension of first matrix
	li $v0, 8
	la $a0, firstDimensionBuffer
	la $a1, 10
	syscall
	
	jr $ra
	

getSecondDimensionFMAsString:
	
	# print enter the second dimension
	li $v0, 4
	la $a0, enterSecondDimensionFM
	syscall
	
	# get the second dimension of first matrix
	li $v0, 8
	la $a0, secondDimensionBuffer
	la $a1, 10
	syscall
	
	jr $ra
	
####------------- Matrix String parse and fill array method Start --------------####

parseMatrix:
	
	# this method takes the $a0 and $a1 as parameter which are $a0 is string buffer and $a1 is array buffer
	
	addi $s0, $zero, -1  # s0 contains the loop counter
	move $s7, $zero
	move $s1, $a0 # set the address of string** buffer to s1 which is passed to the $a0 register
	move $s2, $a1 # set the address of array** buffer to s1 which is passed to the $a1 register
	j parseLoop


parseLoop:
	
	# get the char from incremented address
	addi $s0, $s0, 1   #    s0++
	add $t0, $s0, $s1   #  t0 = s0 + s1    s1 holds address of string buffer
	lb $t1, 0($t0) # $ now t1 contains the value    t1 = array[t0] 
	lb $t2, spaceChar # get the space char byte to compare with in char at $t0
	beq $t1, $t2, setZeroBackLoop
	add $t1, $zero, $t1 # $t1 contains the ascii code of character as integer  
	addi $t2, $zero, 10 # set t2 = 10
	beq $t1, $t2, jumpReturnAddress  #  if t2 == t1 go return address which have been set before calling method.
	addi $t1, $t1, -48 # to convert number ascii code to 4 byte integer value   t1 = t1 - 48
	
	move $a0, $s2 # assign a0 to s2 which contains the current index address of matrix array  
	move $a1, $t1 # assign a1 to t1 qhich is contains the current readed integer value     a1 = t1
	addi $t3, $zero, 1 # set t3 to 1 to be able to compare with s7 		 t3 = 1
	beq $s7, $t3, updateValue # if s7 is still 1 so that we are at second integer which continues of the before number (ex: 12 or 123)   if s7 == 1 go UpdateValue
	sw $t1, 0($s2) # store the current integer at array address
	
	addi $s2, $s2, 4  # increment the address of matrix array index by 1
	addi $s7, $zero, 1
	j parseLoop
	
jumpReturnAddress:
	jr $ra

setZeroBackLoop:  # set condition stack register to 0 and return the register address
	
	move $s7, $zero
	j parseLoop
	
	
updateValue:
	
	lw $t7, -4($a0) 
	addi $t3, $zero, 10  #	t3 = 10
	mul $t7, $t7, $t3   # t7 = t7 * 10
	add $t7, $t7, $a1 # t7 = t7 + a1 ( a1 = 2. basamak )
	sw $t7, -4($a0)	
	
	j parseLoop
	

####-------------Matrix parse and fill array method Finish --------------####


printArrays:
	
	
	li $v0, 1
	la $a0, secondDimension
	lw $a0, 0($a0)
	syscall
	
	jr $ra
	
