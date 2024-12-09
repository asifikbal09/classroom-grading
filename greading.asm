include 'emu8086.inc'

JMP START

DATA SEGMENT 
   	N   DW      ?                                                              
	MARKS DB 1000 DUP (?)           
	ID    DB  1000 DUP (?)
	         
	MSG1    DB 'Enter the number of students(DOES NOT EXCEED 1000): ',0                                  
	MSG2    DB 0Dh,0Ah, 0Dh,0Ah,'Enter the IDs of students: ',0                                        
	MSG3    DB 0Dh,0Ah, 0Dh,0Ah,'Enter the marks of students: ',0    
    	HR      DB 0Dh,0Ah, 0Dh,0Ah,'*******************Sorted Marks***********************',0             
    	MSG4    DB 0Dh,0Ah, 0Dh,0Ah,'ID: ',09H,'MARKS:',0                                
DATA ENDS  

CODE SEGMENT
        	ASSUME DS:DATA CS:CODE     

        	  
START:  	MOV AX, DATA
	  	MOV DS, AX                    
	   
	    	
	    	DEFINE_SCAN_NUM           
        	DEFINE_PRINT_STRING 
        	DEFINE_PRINT_NUM
        	DEFINE_PRINT_NUM_UNS
        
        
        	;Number of Student
        
        	LEA SI,MSG1                 
	    	CALL PRINT_STRING                                                        
	    	CALL SCAN_NUM            
	   	MOV N,CX
	    
	    
	    
	    	;Student Id  
	    	LEA SI,MSG2
	    	CALL PRINT_STRING
	    	MOV SI, 0
	   
LOOP1:  	CALL SCAN_NUM 
        	MOV ID[SI],CL
        	INC SI  
        	PRINT 0AH        
        	PRINT 0DH         
        	CMP SI,N 
        	JNE LOOP1
       
        
        
	    	;Student Marks
	    	LEA SI,MSG3
	    	CALL PRINT_STRING
	    	MOV SI, 0
	   
LOOP2:  	CALL SCAN_NUM 
        	MOV MARKS[SI],CL
        	INC SI  
        	PRINT 0AH        
        	PRINT 0DH       
        	CMP SI,N 
        	JNE LOOP2  
       
        
        
	    	
	    	;Sorting Start 
	    
	    	DEC N            
	   	MOV CX, N                
OUTER:  	MOV SI, 0       
	    
	   
INNER:  	MOV  AL, MARKS[SI]
	    	MOV  DL, ID[SI]
	    	INC  SI
	    	CMP  MARKS[SI], AL
	    	JB   SKIP
	    	XCHG AL, MARKS[SI]
	    	MOV  MARKS[SI-1], AL
	    	XCHG DL, ID[SI]
        	MOV  ID[SI-1], DL
        	;Sorting End 
        
SKIP:   	CMP  SI, CX
	    	JL   INNER 
	    	LOOP OUTER
	    
	    
	    	INC N                       
	    
	   	   
	    	
	    	LEA SI,HR   
	    	CALL PRINT_STRING
	    	LEA SI,MSG4
	    	CALL PRINT_STRING
        	PRINT 0AH             
        	PRINT 0DH            
	   
	    	MOV SI, 0
LOOP3:  	MOV AX,0
        	MOV AL,ID[SI]     
       
        	CALL PRINT_NUM_UNS    
        	PRINT 09H            
        	MOV AL,MARKS[SI]
        	CALL PRINT_NUM_UNS
        	PRINT 0AH            
        	PRINT 0DH            
        	INC SI 
        	CMP SI,N 
        	JNE LOOP3
       
CODE ENDS
 
END START
  

ret
