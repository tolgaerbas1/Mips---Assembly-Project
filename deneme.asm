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
	q1E1 : .asciiz "\nEnter the number of iteration for the series: "
	q2E1 : .asciiz "\nEnter rhe first matrix :"
	q2E2 : .asciiz "\nEnter rhe second matrix :"
	q2E3 : .asciiz "\nEnter the first dimension of first matrix : "
	q2E4 : .asciiz "\nEnter the second dimension of first matrix : " 
	q3E1 : .asciiz "\nEnter an input string : "
	a: .asciiz "a"
	b: .asciiz "b"
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
	la $a0, q1E1
	li $v0, 4               #changing the mode to print string
	syscall
	li $v0, 5	        #changing the mode to read integer
	syscall
	move $t6, $v0
	li $s0, 1 # a = 1
	li $s1, 1 # b = 1
	
	li $v0, 4	#printing a
	la $a0, a
	syscall
	la $a0, space
	li $v0, 4
	syscall
	li $v0, 4	#printing b
	la $a0, b
	syscall
	la $a0, skip
	li $v0, 4
	syscall
	
	li $v0, 1	#printing a
	la $a0, ($s0)
	syscall
	la $a0, space
	li $v0, 4
	syscall
	li $v0, 1	#printing b
	la $a0, ($s1)
	syscall
	la $a0, skip
	li $v0, 4
	syscall
	
	addi $t6, $t6, -1
loop: 	
	beq $t6,$zero, mainMenu
	move $t1, $s0
	move $t2, $s1
	
	add $t3, $t2,$t2  # 2 * b
	add $t4, $t1, $t3 # a2 = a + 2*b   # t3 = new A
	add $t5, $t1, $t2 # b2 = a + b
	li $v0, 1	#printing a
	la $a0, ($t4)
	syscall
	la $a0, space
	li $v0, 4
	syscall
	li $v0, 1	#printing b
	la $a0, ($t5)
	syscall
	la $a0, skip
	li $v0, 4
	syscall
	move $s0, $t4
	move $s1, $t5
	addi $t6, $t6, -1
	j loop
		
question2:
	la $a0, q2E1
	li $v0, 4               #changing the mode to print string
	syscall
	li $v0, 8
	li $a1, 60
	la $a0, array   #recording the input to array' address
	syscall
	move $t0, $a0
	li $t1, 0
	li $v0, 4
	lb $a1, array($t1)
	move $a0, $a1
	
	syscall
	j mainMenu
	
	
	
	
	
	
	
question3:
	
	la $a0, space
	li $v0, 8
	syscall
	
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
