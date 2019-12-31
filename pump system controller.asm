#AUTHORS: OSCAR UWAYO & CHRISTIAN BAGAYA
.data
          prompt1: .asciiz    "Enter the amount of water in (L): "
         var1: .float 0.0
         fp1: .float 800.0
         divider: .float 10.0
          
          
          menu:   .asciiz    "\nPlease Please Enter:Zero to CloseValve(0),One to openValve(1): "
          result:   .asciiz    "The level is: "
          AverageMSG:   .asciiz    "\nThe average is: "
          msg: .asciiz  "\n !!!Warning!!! The tank has reached it's maximum level. Press '0' to close the valve:"
.text
.globl main
main:

         addi $s1,$zero,0
         lwc1 $f4,var1
         lwc1 $f5,fp1
         lwc1 $f6, divider
         add.s  $f2,$f4, $f4  
         add.s  $f3,$f4, $f4 
         add.s $f1, $f5, $f4
         addi $s1, $zero, 0
         
         j controller
controller:
#Temp Variables (Used to decide Operation)
        li $t3, 1
        li $t4, 0
        li $t5, 10


# Menu controls
        li $v0, 4 #Reading a String in Assembly Language
        la $a0, menu
        syscall 
                      
        li $v0, 5 #Reading Integer
        syscall
        move $t2, $v0
   
        # Comparison 
         beq $t2, $t3, open     #open the valve.  
         beq $t2, $t4, Exit     #close the valve.
         bne $t2, $t3, controller
                                                                                          
open:
        li $v0, 4 #Printing a string in Assembly Language]
        la $a0, prompt1    
         syscall    
            
         li $v0, 6 #Reading Integer
         syscall
         #move $t0, $v0                                                         
         #li $v0, 4 #Printing a string in Assembly Language                              
         
         
         
         #reading results
         li $v0, 4 #Reading a String in Assembly Language
         la $a0, result
         
         syscall
         #Perform operation:
         li $v0,2
         #add.s $s1,$t0,$s1
         
         add.s $f2,$f0,$f2
        
         #add.s $f1, $f1, $f2
         #sub.s $f1, $f2, $f1
         c.lt.s  $f1, $f2 
         bc1t warning 
         #Checkin the numver of times that the user has entered water in the tank, when it's 10, we calculate the avarage
         addi $s1, $s1, 1
         beq $s1, $t5, average
         mov.s  $f12, $f2
        
         #mul $t6, $t0, $t0      
         syscall    
    
    
    
         
         
         
          #Average  
         add.s $f3,$f2,$f3
         
         
             
                                       
                                                      
                          
                                        
        # li $v0, 1 #Print Integer
         #la $a0, ($s1)
         #syscall   
         j controller  
         
average:       
         mov.s $f12, $f2
         syscall 
         
  	 #reading results
         li $v0, 4 #Reading a String in Assembly Language
         la $a0, AverageMSG 
         syscall
           
         li $v0,2  
         mov.s $f12, $f3
         div.s $f12, $f12, $f6
         
         #reinitialize average counter
         sub $s1, $s1, $s1
         
         syscall   
        
         j controller                  
 warning:
        
        li $v0, 4 #Reading a String in Assembly Language
        la $a0, msg
        syscall 
                      
        li $v0, 5 #Reading Integer
        syscall
        move $t2, $v0
   
        # Comparison 
         beq $t2, $t4, Exit     #close the valve.
              
           
 Exit:
    li $v0, 10 #Terminate Program
    syscall
  

