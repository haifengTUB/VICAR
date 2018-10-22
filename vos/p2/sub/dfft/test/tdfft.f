
	INCLUDE 'VICMAIN_FOR'
	SUBROUTINE MAIN44
C-----THIS IS A TEST PROGRAM FOR MODULES  dfft AND REALTR
C-----THESE MODULES ARE USED TOGETHER SO ARE TESTED TOGETHER.
C-----A REAL*4 IMAGE IS INPUT (CREATED WITH GEN.
      DIMENSION A(16,18)

	M = 16
	N = 16
        CALL XVUNIT(IUNIT,'INP',1,STAT, ' ')
        CALL XVOPEN(IUNIT,STAT,' ')
	DO I=1,M
           CALL XVREAD(IUNIT,A(1,I),STAT,'LINE',I,'NSAMPS',N, ' ')
        END DO
	M2 = M/2
      IF ( 2*M2 .NE. M ) GO TO 930
C THAT BECAUSE THE DIMENSION MUST BE EVEN IN THE REAL TRANSFORM
C DIRECTION.
      MP2=M + 2
      N2 = 2*N
C
C FORWARD TRANSFORM..
	DO 110 I=1,M
110	CALL PRNT(7,N,A(1,I), 'BEFORE.')
C
      DO 120 I=1,N
      CALL dfft(A(I,1),A(I,2),M2,M2,M2,N2,&950,&960)
      CALL REALTR(A(I,1),A(I,2),M2,N2)
120   CONTINUE
      DO 140 I=2,MP2,2
      CALL dfft(A(1,I-1),A(1,I),N,N,N,1,&950,&960)
140   CONTINUE
	CALL XVMESSAGE( 'THE RESULTING TRANSFORM', ' ')
	DO 130 I=1,MP2
130	CALL PRNT(7,N,A(1,I), 'TRANSFORM.')
C
C THE INVERSE TRANSFORM..
C
      DO 220 I=2,MP2,2
      CALL dfft(A(1,I-1),A(1,I),N,N,N,-1,&950,&960)
220   CONTINUE
      DO 240 I=1,N
      CALL REALTR(A(I,1),A(I,2),M2,-N2)
      CALL dfft(A(I,1),A(I,2),M2,M2,M2,-N2,&950,&960)
240   CONTINUE
	CALL XVMESSAGE( 'REVERSE THE TRANSFORM', ' ')
	S = 2*M*N
	DO 160 I=1,M
        DO J = 1, N
           A(J,I) = A(J,I)/S
        END DO
160	CALL PRNT(7,N,A(1,I), 'AFTER.')
      CALL XVCLOSE(IUNIT,STAT, ' ')
      RETURN
C
930 	CALL XVMESSAGE( 'NUMBER OF LINES MUST BE EVEN', ' ')
	RETURN
C
950 	CALL XVMESSAGE( 'M OR N HAS TOO LARGE A PRIME FACTOR', ' ')
	RETURN
C
960	CALL XVMESSAGE( 
     +  'PRODUCT OF SQUARE-FREE FACTORS OF M OR N TOO BIG',' ')
	RETURN

      END
C************************* START PDF *************************
CPROCESS
CPARM 	INP	TYPE=STRING
CEND-PROC
C**************************** END PDF ***************************