         call inScnTab
mainLp:  ldx 0,i
         lda 0,i
         chari char,d
         ldbytea char,d
         cpa '.',i 
         breq clRdMat
         cpa '*',i
         breq clRdMat
         cpa 's',i
         breq clDiHMat 
         cpa 'a',i
         breq clDiDMat 
         cpa 'c',i
         breq clCount
         cpa 'd',i
         breq clDisc
         cpa 'j',i
         breq clSwp
         cpa 'r',i
         breq clRnd
         cpa 'q',i
         breq clStop
         br mainLp

clRnd:   deci seed,d
         deci densi,d 
         call rndMat
         br mainLp

clRdMat: call rdMat
         br mainLp

clDiHMat:call diHmat
         br mainLp

clDiDMat:call diDmat
         br mainLp

clCount: call count
         br mainLp

clDisc:  call disc
         br mainLp

clSwp:   call swper
         br mainLp

clStop:  stop




; === swper ================================
swper:   subsp 2,i           ; #a 
         call coord
         cpa -1,i
         breq swperOut

         call scn
         sta a,s     

         call swp
         cpa '*',i
         breq swperBm

         deco a,s
         charo '\n',i
         ret2                ; #a 

swperOut:stro inval,d 
         charo '\n',i
         ret2                ; #a 
swperBm: stro boom,d
         charo '\n',i
         ret2                ; #a 

; === swp ==================================
;ind:     .equate 2           ; #2d
;x:       .equate 0           ; #2d
swp:     subsp 4,i           ; #ind #x
         call uSrch
         cpa '1',i
         breq swpRt
         cpa '\n',i
         breq swpRt
         
         call di
         cpa '.',i
         brne swpRt
         
         stx ind,s
         ldx 0,i     
swpLp:   cpx 18,i             ; for( 0 à 9 )
         brge swpRt
         stx x,s
         ldx scnTab,x
         addx ind,s
         call swp
         ldx x,s
         addx 2,i
         br swpLp
         
swpRt:   ret4                ; #ind #x 

         
uSrch:  call inBnd
        cpa 0,i
        breq uSrchOut
        
        ldbytea dMat,x
        cpa '#',i
        breq uSrch1
uSrch0: ldbytea '1',i
        ret0
uSrch1: ldbytea '#',i
        ret0        
uSrchOut:ldbytea '\n',i
        ret0


; === disc =================================
disc:    subsp 2,i           ; #a 
         call coord 
         cpa -1,i
         breq discOut

         call di
         cpa '*',i
         breq discBm
         call scn
         sta a,s
         deco a,s
         charo '\n',i
         ret2                ; #a 

discOut: stro inval,d
         charo '\n',i
         ret2                ; #a 
discBm:  stro boom,d
         charo '\n',i     
         ret2                ; #a 

; === di ===================================
cast:    .equate 0           ; #2d
di:      subsp 2,i           ; #cast              
         ldbytea hMat,x
         cpa '*',i
         breq diRt

         call scn 
         cpa 0,i
         breq di0
         
         sta cast,s
         ldbytea 48,i
         adda cast,s
         br diRt      
         
di0:     ldbytea '.',i
diRt:    stbytea dMat,x
         ret2                ; #cast 

; === count ================================
cnt:     .equate 0           ; #2d 
count:   subsp 2,i           ; #cnt
         ldx 0,i
countLp: cpx 110,i
         brge countRt        
         
         ldbytea hMat,x      ; if( hMat[X] == \n )
         cpa '\n',i          
         breq countNl
         cpa '*',i
         breq countBm

         call scn            
         sta cnt,s           
         cpa 0,i
         breq countVd

         deco cnt,s
         addx 1,i            
         br countLp          

countVd: charo '.',i
         addx 1,i
         br countLp

countBm: charo '*',i
         addx 1,i
         br countLp

countNl: charo '\n',i
         addx 1,i
         br countLp

countRt: addsp 2,i           ; #cnt
         ret0


; === coord ================================
; return X
; description:
;         read row and col from input
;        return corresponding indice in matrix
row:     .equate 2           ; #2d
col:     .equate 0           ; #2d
coord:   subsp 4,i           ; #row #col         
         deci row,s 
         lda row,s
         adda -1,i
         sta row,s

         deci col,s
         lda col,s
         adda -1,i
         sta col,s

         lda row,s
         ldx col,s
         cpa 0,i             ; if( row <0 | row >=10 | col <0 | col >=10 ){
         brlt coordOut       ;    isOutOfBound
         cpx 0,i             ; }
         brlt coordOut
         cpa 10,i
         brge coordOut
         cpx 10,i
         brge coordOut
         lda 0,i             ; else{
         ldx 0,i
coordLp: cpx row,s
         brge coordLp2
         adda 11,i
         addx 1,i
         br coordLp
coordLp2:adda col,s
         br coordRt

coordOut:lda -1,i
         ldx -1,i
         
coordRt: sta col,s
         ldx col,s
         addsp 4,i          ; #row #col
         ret0
         
; === scn ==================================
; param X
; return X, A
mine:    .equate 4           ; #2d
ind:     .equate 2           ; #2d
x:       .equate 0           ; #2d
scn:     subsp 6,i           ; #mine #ind #x 
         stx ind,s 
         lda 0,i
         sta mine,s          ; mine = 0
         ldx 0,i     
scnLp:   cpx 18,i             ; for( 0 à 9 )
         brge scnRt 
         stx x,s             ; x = X
         ldx scnTab,x 
         addx ind,s
         call srch
         cpa '*',i
         breq scnMine
         br scnLp2

scnMine: lda mine,s
         adda 1,i
         sta mine,s
         
scnLp2:  ldx x,s
         addx 2,i
         stx x,s
         br scnLp

scnRt:   lda mine,s
         ldx ind,s
         addsp 6,i           ; #mine #ind #x 
         ret0         

; === srch ==================================
; srch(X) return A[\n,.,*]
; description:
;        return 0 if coordnate are not mined
;        return 1 if coordonate are mined
srch:    call inBnd
         cpa 0,i
         breq srchOut
         ldbytea hMat,x
         cpa '*',i
         breq srch1
srch0:   ldbytea '.',i
         ret0
srch1:   ldbytea '*',i
         ret0
srchOut: ldbytea '\n',i
         ret0

; === inBnd =================================
inBnd:   cpx 0,i
         brlt outBnd
         cpx 110,i
         brge outBnd
         ldbytea hMat,x
         cpa '\n',i
         breq outBnd
         lda 1,i
         ret0
outBnd:  lda 0,i
         ret0

; === inDMat ================================
; description:
;         initialise the discovery matrix
inDMat:  ldx 0,i
dMatLp:  cpx 110,i
         brge dMatRt 
         ldbytea hMat,x
         cpa '.',i
         breq hash
         cpa '*',i
         breq hash
         stbytea dMat,x
         addx 1,i
         br dMatLp
hash:    ldbytea '#',i
         stbytea dMat,x
         addx 1,i
         br dMatLp
dMatRt:  ret0

; === rdHmat ================================
rdMat:   ldx 0,i
         ldbytea char,d
         stbytea hMat,x
         addx 1,i
rdMatLp: cpx 110,i
         brge rdMatRt 
         chari char,d
         ldbytea char,d         
         stbytea hMat,x
         addx 1,i
         br rdMatLp
rdMatRt: call inDMat
         ret0


; === diHmat =================================
; description:   
;        displays the hidden matrix
diHmat:  ldx 0,i
diHmatLp:cpx 110,i
         brge diHmatRt 
         charo hMat,x
         addx 1,i
         br diHmatLp
diHmatRt:ret0

; === diDmat =================================
; description: 
;         displays the discovery matrix
;
diDmat:  ldx 0,i
diDmatLp:cpx 110,i
         brge diDmatRt 
         charo dMat,x
         addx 1,i
         br diDmatLp
diDmatRt:ret0

; === inScnTab =============================
inScnTab:lda -12,i           ;0:-12
         ldx 0,i             
         sta scnTab,x
         adda 1,i            ;1:-11
         addx 2,i            
         sta scnTab,x
         adda 1,i            ;2:-10
         addx 2,i
         sta scnTab,x
         lda -1,i            ;3:-1
         addx 2,i
         sta scnTab,x
         adda 1,i            ;4:0
         addx 2,i
         sta scnTab,x
         adda 1,i            ;5:1
         addx 2,i
         sta scnTab,x
         lda 10,i            ;6:10
         addx 2,i
         sta scnTab,x
         adda 1,i            ;7:11
         addx 2,i
         sta scnTab,x
         adda 1,i            ;8:12
         addx 2,i
         sta scnTab,x

         lda 0,i
         ldx 0,i
         ret0       

; === rndMat ==================================
rndNl:   .equate 2           ; #2d
; x:     .equate 0           ; #2d
rndMat:  subsp 4,i           ; #rndNl #x       
         
         lda 10,i
         sta rndNl,s
         
         ldx 0,i
rndLp:   cpx 110,i
         brge rndMatRt
         
         cpx rndNl,s
         breq rndLpNl

         call rnd
         cpa densi,d
         brlt rndMine
         sta x,s
         ldbytea '.',i
         stbytea hMat,x
         lda x,s
         addx 1,i
         br rndLp         

rndMine: sta x,s
         ldbytea '*',i
         stbytea hMat,x
         lda x,s
         addx 1,i
         br rndLp

rndLpNl: sta x,s
         ldbytea '\n',i
         stbytea hMat,x
         lda x,s
         addx 11,i
         stx rndNl,s
         subx 10,i
         br rndLp
rndMatRt:ret4                ; #rndNl #x 

; === rnd =====================================
a:       .equate 6           ; #2d
b:       .equate 4           ; #2d
c:       .equate 2           ; #2d
d:       .equate 0           ; #2d
rnd:     subsp 8,i           ; #d #c #b #a
         lda seed,d

         ; x ^= x << 5
         sta a,s
         asla 
         asla 
         asla 
         asla
         asla
         sta b,s
         lda a,s
         ora b,s
         sta c,s
         lda a,s
         anda b,s
         nota
         sta d,s
         anda c,s
         sta a,s

         ; x ^= x >> 4
         lda a,s
         asra
         asra
         asra
         asra
     
         sta b,s
         lda a,s
         ora b,s
         sta c,s
         lda a,s
         anda b,s
         nota
         sta d,s
         anda c,s
         sta a,s

         ; x ^= x << 9
         lda a,s
         asla 
         asla
         asla 
         asla
         asla 
         asla 
         asla
         asla 
         asla

         sta b,s
         lda a,s
         ora b,s
         sta c,s
         lda a,s
         anda b,s
         nota
         sta d,s
         anda c,s
         sta a,s
         sta seed,d

         ; x & 255 
         lda a,s
         anda 255,i
         addsp 8,i           ; #d #c #b #a
         ret0
; ===============================================


scnTab:  .block 18           ; #2d9a
dMat:    .block 110          ; #1c110a                  
hMat:    .block 110          ; #1c110a 
char:    .block 1            ; #1c
num:     .block 2            ; #2d
seed:    .block 2            ; #2d 
densi:   .block 2            ; #2d
boom:    .ascii "Boum!\x00"
inval:    .ascii "Coup invalide.\x00"
         .end