10 REM Eggs 'N Basket
20 REM By Myles Thaiss
30 HIGH% = 0
40 VDU 23,240,24,60,60,126,126,126,126,60
50 VDU 23,241,0,0,0,126,60,24,0,0
60 VDU 23,242,127,127,127,127,63,31,15,7
70 VDU 23,243,255,255,255,255,255,255,255,255
80 VDU 23,244,254,254,254,254,252,248,240,224
90 GOSUB 960
100 MODE 2
110 VDU 23,1,0;0;0;0;
120 PRINT TAB(2,1)CHR$(17)+CHR$(1)"1UP"
130 PRINT TAB(12,1)CHR$(17)+CHR$(1)"HIGH"
140 LEVEL% = 1 : SCORE% = 0 : BONUS% = 10000
150 LIVES% = 3 : EGGS% = 0 : BASKET% = 0 : X% = 9 
160 GOSUB 640 : GOSUB 680 : GOSUB 770 : GOSUB 800
170 REPEAT
180 C% = RND(10) : E% = RND(16) + 1 : Y% = 4
190 IF C% > LEVEL% AND C% <> 3 THEN GOSUB 400
200 IF C% = 3 THEN S% = 1 ELSE S% = 11 - C%
210 T% = 0
220 IF T% = 0 THEN GOSUB 430 ELSE T% = T% - 1
230 KEY% = INKEY(1)
240 IF KEY% = 65 OR KEY% = 97 THEN GOSUB 900
250 IF KEY% = 68 OR KEY% = 100 THEN GOSUB 930
260 IF KEY% = 87 OR KEY% = 119 THEN GOSUB 740
270 PRINT TAB(X% - 2, 28)CHR$(17)+CHR$(6)" " CHR$(242)
280 PRINT TAB(X%, 28)CHR$(17)+CHR$(6)CHR$(243)
290 PRINT TAB(X% + 1, 28)CHR$(17)+CHR$(6)CHR$(244)" "
300 IF Y% < 28 THEN GOTO 220
310 IF E% = X% AND Y% = 28 AND BASKET% < 10 THEN GOSUB 480 ELSE GOSUB 540
320 PRINT TAB(E%,27)" "
330 UNTIL LIVES% = 0
340 PRINT TAB(X% - 1, 28)"     " : PRINT TAB(9,30)"   "
350 PRINT TAB(5,15)CHR$(17)+CHR$(3)"GAME OVER!"
360 REPEAT
370 KEY% = INKEY(1)
380 UNTIL KEY% = 32
390 GOTO 100
400 REM Alt egg colour
410 IF LEVEL% = 3 AND C% <> 3 THEN C% = 4 ELSE C% = LEVEL%
420 RETURN
430 REM Move / display egg and reset timer
440 PRINT TAB(E%,Y% - 1)" "
450 PRINT TAB(E%,Y%)CHR$(17)+CHR$(C%)CHR$(240)
460 T% = S% : Y% = Y% + 1
470 RETURN
480 REM Catched egg
490 EGGS% = EGGS% + 1 : BASKET% = BASKET% + 1
500 IF EGGS% = 10 + LEVEL% * 2 THEN GOSUB 600
510 IF C% = 3 THEN SCORE% = SCORE% + 430 ELSE SCORE% = SCORE% + 20 * C%
520 GOSUB 680 : GOSUB 770
530 RETURN
540 REM Missed egg
550 SOUND 0,-10,22,18 
560 IF C% <> 3 THEN LIVES% = LIVES% - 1
570 GOSUB 640
580 IF BASKET% = 10 THEN BASKET% = 0 : GOSUB 770
590 RETURN
600 REM Level up
610 LEVEL% = LEVEL% + 1 : EGGS% = 0
620 GOSUB 800
630 RETURN
640 REM Lives status
650 PRINT TAB(1,30)"   "
660 PRINT TAB(1,30)CHR$(17)+CHR$(6)STRING$(LIVES%,CHR$(241))
670 RETURN
680 REM Score status
690 IF SCORE% > HIGH% THEN HIGH% = SCORE%
700 IF SCORE% > BONUS% THEN GOSUB 840
710 PRINT TAB(1,2)CHR$(17)+CHR$(7)LEFT$(STR$(SCORE%),8)
720 PRINT TAB(11,2)CHR$(17)+CHR$(7)LEFT$(STR$(HIGH%),8)
730 RETURN
740 REM Empty basket
750 IF BASKET% <> 0 THEN SCORE% = SCORE% + BASKET% * 10 : BASKET% = 0 : GOSUB 680 : GOSUB 770
760 RETURN
770 REM Basket status
780 IF BASKET% > 0 THEN PRINT TAB(9,30)STR$(BASKET% * 10) ELSE PRINT TAB(9,30)"   "
790 RETURN
800 REM Level status
810 PRINT TAB(17,30)"  "
820 PRINT TAB(17,30)CHR$(17)+CHR$(3)LEFT$(STR$(LEVEL%),2)
830 RETURN
840 REM 1Up
850 IF LIVES% < 3 THEN LIVES% = LIVES% + 1 ELSE SCORE% = SCORE% + 150
860 BONUS% = BONUS% + 10000
870 SOUND 1,-15,60,10
880 GOSUB 640 : GOSUB 680
890 RETURN
900 REM Move basket to the left
910 IF X% - 2 > 0 THEN X% = X% - 1
920 RETURN
930 REM Move basket to the right
940 IF X% + 2 < 19 THEN X% = X% + 1
950 RETURN
960 REM Title screen
970 MODE 7
980 VDU 23,1,0;0;0;0;
990 PRINT TAB(10,8)CHR$(141)CHR$(131)"Eggs"CHR$(135)"'N'"CHR$(131)"Basket"
1000 PRINT TAB(10,9)CHR$(141)CHR$(135)"Eggs 'N' Basket"
1010 PRINT TAB(9,13)CHR$(130)"Keys:"
1020 PRINT TAB(16,13)CHR$(134)"A = Move left."
1030 PRINT TAB(16,14)CHR$(134)"D = Move right."
1040 PRINT TAB(16,15)CHR$(134)"W = Empty basket."
1050 PRINT TAB(12,22)CHR$(135)CHR$(136)"Press SPACE"
1060 REPEAT
1070 KEY% = INKEY(1)
1080 UNTIL KEY% = 32
1090 RETURN
