# Joshua Bonner
# CMPSC 312
# Homework 2 "Pythagorean Triples"

.data
newLine:		.asciiz "\n"	# create new line in text prompt
user_query:		.asciiz "\nPlease enter 3 separate integers :\n"
user_prompt:		.asciiz "\nEnter 1 to try again, or 0 to exit program : "
intVal1:		.word 0
intVal2:		.word 0
intVal3:		.word 0
multVal1:		.word 0
multVal2:		.word 0
multVal3:		.word 0
satisfied_condition: 	.asciiz "These integers are Pythagorean Triples!\n"
unsatisfied_condition:	.asciiz "These integers are NOT Pythagorean Triples!\n"
improper_input:		.asciiz "You have entered an invalid value! Please try again.\n"

.text
.globl main

main:	

	# prompt user for input
	li $v0, 4		# load system call code to print string
	la $a0, user_query	# load user_query string
	syscall			# print contents of user_query
	
	# store user input into intVals
	li $v0, 5		# load system call code to read integer input
	syscall			# read integer value into $v0
	blt  $v0, 1, error	# user input validation
	move $s1, $v0		# move contents $v0 into $s1
	sw $s1, intVal1		# store contents of $s1 into intVal1
	
	li $v0, 5		# load system call code to read integer input
	syscall			# read integer value into $v0
	blt  $v0, 1, error	# user input validation
	move $s1, $v0		# move contents $v0 into $s1
	sw $s1, intVal2		# store contents of $s1 into intVal2
	
	li $v0, 5		# load system call code to read integer input
	syscall			# read integer value into $v0
	blt  $v0, 1, error	# user input validation
	move $s1, $v0		# move contents $v0 into $s1
	sw $s1, intVal3		# store contents of $s1 into intVal3
			
	# Multiply intVals by themselves to simulate squaring them
	lw $t0, intVal1
	mul $t1, $t0, $t0
	sw $t1, multVal1	# square intVal1 and store it into multVal1
	
	lw $t0, intVal2
	mul $t1, $t0, $t0
	sw $t1, multVal2	# square intVal2 and store it into multVal2
	
	lw $t0, intVal3
	mul $t1, $t0, $t0
	sw $t1, multVal3	# square intVal3 and store it into multVal3
	
	# Add multVals and check for Pythagorean Triples
	lw $t0, multVal1
	lw $t1, multVal2
	lw $t2, multVal3
	add $t3, $t1, $t0
	beq $t3, $t2, go	# if multVal1 + multVal2 = multVal3 then pythagorean triple
	
	lw $t0, multVal2
	lw $t1, multVal3
	lw $t2, multVal1
	add $t3, $t1, $t0
	beq $t3, $t2, go	# if multVal2 + multVal3 = multVal1 then pythagorean triple
	
	lw $t0, multVal3
	lw $t1, multVal1
	lw $t2, multVal2
	add $t3, $t1, $t0
	beq $t3, $t2, go	# if multVal3 + multVal1 = multVal2 then pythagorean triple
	
	# if pythagorean triple is not found, then inform user
	li $v0, 4
	la $a0, newLine
	syscall
	li $v0, 4
	la $a0, unsatisfied_condition
	syscall
	
	# ask user if they would like to try again
	li $v0, 4
	la $a0, user_prompt
	syscall
	li $v0, 5
	syscall
	li $s0, 1
	beq $s0, $v0, main
	bne $s0, $v0, end
	
	
	# if pythagorean triple is found, then inform user
go:	li $v0, 4
	la $a0, newLine
	syscall
	li $v0, 4
	la $a0, satisfied_condition
	syscall
	
	# ask user if they would like to try again
	li $v0, 4
	la $a0, user_prompt
	syscall
	li $v0, 5
	syscall
	li $s0, 1
	beq $s0, $v0, main
	bne $s0, $v0, end
	
end:	# TERMINATE PROGRAM
	li $v0, 10
	syscall
	
	# inform user of invalid input and loop back to main
error:	li $v0, 4
	la $a0, improper_input
	syscall
	j main
