C    01 MAY 1991 ...REA... Conversion to UNIX/VICAR
C    29 JUL 1985 ...JHR... allow half,full,real data types
C    02 NOV 1984 ...BXG... converted to VICAR2
C    29 FEB 1984 ...SJR... converted for use on the VAX 11/780 
C    27 JUN 1975 ...DAH... CHANGES FOR CONVERSION TO 360/OS
C     INSERT SECTOR FROM SECONDARY PICTURE INTO PRIMARY PICTURE
C
      INCLUDE 'VICMAIN_FOR'
      SUBROUTINE MAIN44
C
      INTEGER SL,SS,BYTPIX
      INTEGER IPARM(6),OUNIT,SL2,SS2,STAT
      LOGICAL*1 BUF(20000)
      CHARACTER*8 FORM1,FORM2
C
      CALL XVPARM('INSECT',IPARM,ICOUNT,IDEF,0)
C
C        OPEN INPUT DATA SETS
      CALL XVUNIT(IUNIT1,'INP',1,STAT,' ')
      CALL XVOPEN(IUNIT1,STAT,'OPEN_ACT','SA','IO_ACT','SA',' ')
      CALL XVUNIT(IUNIT2,'INP',2,STAT,' ')
      CALL XVOPEN(IUNIT2,STAT,'OPEN_ACT','SA','IO_ACT','SA',' ')
C
C        CHECK THAT BOTH FORMATS ARE THE SAME
      CALL XVGET(IUNIT1,STAT,'NL',NLI1,'NS',NSI1,'FORMAT',FORM1,' ')
      CALL XVGET(IUNIT2,STAT,'NL',NLI2,'NS',NSI2,'FORMAT',FORM2,' ')
      IF(FORM1.NE.FORM2) THEN
	 CALL XVMESSAGE(' INPUTS MUST BE IN THE SAME FORMAT',' ')
	 CALL ABEND
      ENDIF
      BYTPIX=0
      IF(FORM1.EQ.'BYTE') BYTPIX=1
      IF(FORM1.EQ.'HALF') BYTPIX=2
      IF(FORM1.EQ.'FULL') BYTPIX=4
      IF(FORM1.EQ.'REAL') BYTPIX=4
      IF(BYTPIX.EQ.0) THEN
	 CALL XVMESSAGE(' INVALID DATA FORMAT',' ')
	 CALL ABEND
      ENDIF
C
      CALL XVSIZE(SL,SS,NL,NS,NLI,NSI)
      IF(NS.GT.20000) THEN
	 CALL XVMESSAGE(' IMAGE SIZE EXCEEDS BUFFER SIZE',' ')
	 CALL ABEND
      ENDIF
C
C        OPEN OUTPUT DATA SET
      CALL XVUNIT(OUNIT,'OUT',1,STAT,' ')
      CALL XVOPEN(OUNIT,STAT,'OP','WRITE','U_NL',NL,'U_NS',NS,
     +		  'OPEN_ACT','SA','IO_ACT','SA',' ')
C
      SL2=IPARM(1)
      SS2=IPARM(2)
      NL2=IPARM(3)
      NS2=IPARM(4)
      LN2=IPARM(5)
      SN2=IPARM(6)
      NL1=NLI-SL+1
      NS1=NSI-SS+1
      IL1=SL
      IL2=SL2
      BN2=BYTPIX*(SN2-1)+1
      NB=BYTPIX*NS
C
      DO L=1,NL
         CALL ITLA(0,BUF,NB)
         IF(L.LE.NL1) THEN
            CALL XVREAD(IUNIT1,BUF,STAT,'LINE',IL1,'SAMP',SS,
     &                 'NSAMPS',NS1,' ')
            IL1=IL1+1
         END IF
         IF(L.GE.LN2.AND.L.LT.LN2+NL2) THEN
            CALL XVREAD(IUNIT2,BUF(BN2),STAT,'LINE',IL2,
     &                 'SAMP',SS2,'NSAMPS',NS2,' ')
            IL2=IL2+1
         END IF
         CALL XVWRIT(OUNIT,BUF,STAT,'NSAMPS',NS,' ')
      ENDDO

C        CLOSE DATA SETS
      CALL XVCLOSE(IUNIT1,STAT,' ')
      CALL XVCLOSE(IUNIT2,STAT,' ') 
      CALL XVCLOSE(OUNIT,STAT,' ')

      RETURN
      END
