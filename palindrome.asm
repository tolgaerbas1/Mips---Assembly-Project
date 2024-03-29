.data

# string messages
enterAnInputStr:	.asciiz "Enter an input string: "
isNotPalindromeStr:	.asciiz " is not a palindrome."
isPalindromeStr:	.asciiz " is a palindrome."
newLine:		.asciiz "\n"
spaceChar:		.asciiz " "

# buffer size
inputStrBuffer:		.space 100
inputCharAsciiDec:	.space 4
inputLastCharPointer:	.space 4
resultStr:		.space 125

.text

	j q3

q3:
	# print enter an input
	li $v0, 4
	la $a0, enterAnInputStr
	syscall
	
	# get input string from user
	li $v0, 8
	la $a0, inputStrBuffer
	li $a1, 105
	syscall
	
	li $s0, -1
	jal beforeConvertLowerAndGetLength
	jal beforeCheckPalindrome
	
	li $v0, 10
	syscall
	
beforeCheckPalindrome:
	
	move $s7, $ra

	li $s1, 0 # it will be increased 
	addi $s0, $s0, -1 # s0 contains the length of str it will be decreased.
	
	#la $s1, inputStrBuffer
	
	j checkPalindrome
	
checkPalindrome:

	ble $s0, $s1, isPalindrome
		
	la $t0, inputStrBuffer
	add $t1, $t0, $s1
	add $t2, $t0, $s0
 	
	lb $t1, 0($t1)
	lb $t2, 0($t2)
	
	addi $s1, $s1, 1
	addi $s0, $s0, -1
	
	beq $t1, $t2, checkPalindrome
	
	j isNotPalindrome
	
isPalindrome:
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	la $a1, inputStrBuffer
	la $a0, resultStr
	jal stringConcatStart
	
	
	la $a1, isPalindromeStr
	jal stringConcatStart

	li $v0, 4
	la $a0, resultStr
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall

	jr $s7
	
	
isNotPalindrome:
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	la $a1, inputStrBuffer
	la $a0, resultStr
	jal stringConcatStart
	
	
	la $a1, isNotPalindromeStr
	jal stringConcatStart

	li $v0, 4
	la $a0, resultStr
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall

	jr $s7
	
stringConcatStart:
	# a0 is is the address of result str will store
	# a1 is the will concatinate string address
	
	move $s1, $a0
	move $s2, $a1
	j stringConcat
	


stringConcat:

	lb $t0, 0($s2)
	move $a0, $s1 # store the last added char address in result str to continue from here when adding the other string to the this.
	addi, $t1, $zero, 10
	beq $t0, $t1, jumpBackPal
	sb $t0, 0($s1)
	addi $s1, $s1, 1 # increment the address by 1 because the we will store byte.
	addi $s2, $s2, 1
	j stringConcat
	
jumpBackPal:
	
	jr $ra
	

	
beforeConvertLowerAndGetLength:
	
	move $s7, $ra
	j convertLowerAndGetLength
	

convertLowerAndGetLength:

	addi $s0, $s0, 1
	la $t0, inputStrBuffer # t0 contains address of input string
	add $t0, $t0, $s0 # add index count to address to get char from string at that index
	lb $t1, 0($t0) # load byte from address to can get character 
	li $t2, 10 # t2 contains the line ending decimal
	beq $t1, $t2, returnBack
	
	move $a0, $t1 # move byte value to a0 
	move $a1, $t0 # move current loaded character address to a1
	li $t2, 97
	blt $t1, $t2, convertLower
 	j convertLowerAndGetLength

convertLower:
	
	# a0 byte value
	# a1 will store address
	
	li $t0, 32 # t1 = " " ,  ascii decimal of spcace char is 32
	beq $a0, $t0, convertLowerAndGetLength # if it is space char go back to the loop.
	addi $a0, $a0, 32 # add 32 to convert upper letter to lower case.
	sb $a0, 0($a1) # store byte to store address
	
	j convertLowerAndGetLength

returnBack:

	jr $s7

