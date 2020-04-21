.data 
	array: .space 60
	str:   .space 26
	space: .asciiz " "
	skip:  .asciiz "\n"
	hello: .asciiz "Welcome to our MIPS project"
	menu:  .asciiz "\nMain Menu:"
	menu1: .asciiz "\n1. Square Root"
	menu2: .asciiz "\n2. Matrix Multiplication"
	menu3: .asciiz "\n3. Palindrome"
	menu4: .asciiz "\n4. Exit"
	menuO: .asciiz "\nPlease select an option:"
	exitT: .asciiz "\nProgram ends. Bye :)"
	q2E1 : .asciiz "\nEnter rhe first matrix :"
	q2E2 : .asciiz "\nEnter rhe second matrix :"
	q2E3 : .asciiz "\nEnter the first dimension of first matrix : "
	q2E4 : .asciiz "\nEnter the second dimension of first matrix : " 
	q3E1 : .asciiz "\nEnter an input string : "
	# q3E8 : .asciiz "blabla"

.text
	li $s4, 1  #Choices
	li $s5, 2
	li $s6, 3
	li $s7, 4
mainMenu:
	li $v0, 4
	la $a0, hello
	syscall
	li $v0, 4
	la $a0, menu
	syscall
	li $v0, 4
	la $a0, menu1
	syscall
	li $v0, 4
	la $a0, menu2
	syscall
	li $v0, 4
	la $a0, menu3
	syscall
	li $v0, 4
	la $a0, menu4
	syscall
	li $v0, 4
	la $a0, menuO
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	beq $t0, $s4, question1
	beq $t0, $s5, question2
	beq $t0, $s6, question3
	beq $t0, $s7, exit
question1:
	
	j mainMenu
question2:
	j mainMenu
question3:
	li $v0, 4
	la $a0, q3E1
	syscall
	
	j mainMenu
exit:
	li $v0, 4
	la $a0, exitT
	syscall
	li $v0, 10
	syscall