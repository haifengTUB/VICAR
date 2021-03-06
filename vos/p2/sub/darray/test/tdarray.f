C TDARRAY IS A PROGRAM TO TEST THE SUBROUTINE
C DARRAY.
C
        SUBROUTINE TDARRAY()

	INTEGER*4 MODE,I,J,M,N,K,ID,IS
        REAL*8 S1(5,5), D1(10,10)
        CHARACTER*35 MS1
        CHARACTER*100 MS2,MS3
C FIRST TEST MODE 1 WITH 10 X 10
	IS = 5
        ID = 10
	K=0
	DO 5 I = 1,IS
	DO 6 J = 1,IS
	S1(I,J) = (J+I)/1.0
6       CONTINUE
5       CONTINUE
	DO 7 I = 1,ID
	DO 8 J = 1,ID
	D1(I,J) = 0.0
8       CONTINUE
7       CONTINUE
	MODE = 1
	J=IS
	I = IS
	N = ID 
	M = ID
	CALL DARRAY(MODE,I,J,N,M,S1,D1)
        WRITE(MS1,2000)
2000	FORMAT(' MODE 1 :.')
        CALL XVMESSAGE(MS1, ' ')
	DO 15 K = 1,IS
	WRITE(MS2,100) S1(1,K),S1(2,K),S1(3,K),S1(4,K),S1(5,K)
        CALL XVMESSAGE(MS2, ' ')
15      CONTINUE
        WRITE(MS1,6000)
        CALL XVMESSAGE(MS1, ' ')
	DO 25 K = 1,ID
	WRITE(MS2,100) D1(1,K),D1(2,K),D1(3,K),D1(4,K),D1(5,K)
        WRITE(MS3,100) D1(6,K),D1(7,K),D1(8,K),D1(9,K),D1(10,K)
        CALL XVMESSAGE(MS2, ' ')
        CALL XVMESSAGE(MS3, ' ')
25      CONTINUE
100     FORMAT(5E12.4)
C NEXT MODE 2 WITH A 10 X 10
	IS = 5
        ID = 10
	K=0
	DO 105 I = 1,IS
	DO 106 J = 1,IS
	S1(I,J) = 0.0
106     CONTINUE
105     CONTINUE
	DO 107 I = 1,ID
	DO 108 J = 1,ID
	D1(I,J) = (J+I)/1.0
108     CONTINUE
107     CONTINUE
	MODE = 2
	J=IS
	I = IS
	N = ID 
	M = ID
	CALL DARRAY(MODE,I,J,N,M,S1,D1)
        WRITE(MS1,3000)
3000	FORMAT(' MODE 2: ')
        CALL XVMESSAGE(MS1, ' ')
	DO 115 K = 1,IS
	WRITE(MS2,100) S1(1,K),S1(2,K),S1(3,K),S1(4,K),S1(5,K)
        CALL XVMESSAGE(MS2, ' ')
115     CONTINUE
        WRITE(MS1,6000)
        CALL XVMESSAGE(MS1, ' ')
	DO 125 K = 1,ID
	WRITE(MS2,100) D1(1,K),D1(2,K),D1(3,K),D1(4,K),D1(5,K)
        WRITE(MS3,100) D1(6,K),D1(7,K),D1(8,K),D1(9,K),D1(10,K)
        CALL XVMESSAGE(MS2, ' ')
        CALL XVMESSAGE(MS3, ' ')
125     CONTINUE
6000    FORMAT(' D ARRAY: ')
        END
