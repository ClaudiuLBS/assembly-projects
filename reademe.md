Exemplu de translatare:

Sa consideram ca vrem sa reprezentam instructiunea x 1 let x -14 div.
Vom folosi formatele descrise mai sus, si vom reprezenta pe rand fiecare camp.

1. x: cum a fost aratat intr-un exemplu de mai sus, x se codifica 1 01 0 01111000. Vom grupa
   cate 4 cifre, astfel ca reprezentarea lui x este 1010 0111 1000.
2. il codificam pe 1. Este o codificare de operand numar intreg pozitiv, deci avem identificatorul
   00 si bit-ul de semn 0. Reprezentarea lui va fi 1 00 0 00000001, iar pe gruparea cate 4 cifre
   1000 0000 0001.
3. let este o operatie, se va codifica precum o operatie, avand deci identificatorul 10, respectiv
   codul de operatie 000000000. Reprezentarea lui va fi 1 10 000000000, iar pe gruparea cate 4
   cifre 1100 0000 0000.
4. x se va reprezenta din nou ca 1010 0111 1000.
5. -14 se reprezinta ca operand numar intreg negativ, deci cu identificatorul 00, bit-ul de semn 1,
   iar valoarea 14 in baza 2 → 1110, dar pe 8 biti, deci cu 4 biti de 0 la stanga (nesemnificativi):
6. -14 va fi reprezentat, deci 1 00 1 00001110, iar pe gruparea cate 4 cifre 1001
   0000 1110.
7. In final, div este o operatie, deci identificatorul 10, si codificarea oepratiei conform tabelului
   000000100, astfel ca va fi 1 10 000000100, iar pe gruparea cate 4 cifre 1100 0000 0100.
   In acest caz, putem concatena toate reprezentarile binare, si sa avem:
   1010 0111 1000 1000 0000 0001 1100 0000 0000 1010 0111 1000 1001 0000 1110 1100 0000
   0100
   respectiv in hexa:
   A7 88 01 C0 0A 78 90 EC 04
   Avem, astfel, ca operatia din assembly-ul nostru, x 1 let x -14 div, se translateaza in cod
   masina in reprezentare hexa in A7 88 01 C0 0A 78 90 EC 04.

Cerinta 1:

Fie dat ca input un sir hexa, se cere sa se afiseze la standard output instructiunea assembly de
executat.
De exemplu, pentru inputul A78801C00A7890EC04, se va afisa la standard output x 1 let x
-14 div.

Cerinta 2:

Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat, se
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, in instructiune
nu exista variabile, ea fiind formata doar din numere intregi si operatii.
De exemplu, poate fi data instructiunea 2 10 mul 5 div 7 6 sub add. Rezultatul trebuie sa
fie conform urmatorului algoritm:
• se adauga 2 pe stiva;
• se adauga 10 pe stiva;
• se identifica operatia mul, se aplica inmultirea dintre 2 si 10, se obtine 20, se elimina 2 si 10
de pe stiva si se pastreaza doar 20;
• se adauga 5 pe stiva;
• se identifica div - actioneaza ca 20 div 5, iar rezultatul este 4; se elimina 20 si 5 de pe stiva,
si se pastreaza doar 4;
• se adauga 7 pe stiva;
• se adauga 6 pe stiva;
• se identifica sub - se calculeaza diferenta dintre 7 si 6, se obtine 1, se elimina 7 si 6 de pe stiva,
si se adauga pe stiva valoarea 1. Atentie! in acest moment, pe stiva avem 4 (la baza) si 1 in
varf, intrucat sub este operatie binara si a lucrat doar cu argumentele 7 si 6, dar nu si cu 4
care era deja la baza stivei.
• se identifica add - se calculeaza suma dintre 1 si 4, se obtine 5, se elimina 1 si 4 de pe stiva, se
adauga 5;
• am terminat de parcurs sirul, iar rezultatul obtinut este, acum, situat in varful stivei. Rezultatul acestui calcul este 5.

Cerinta 3:

Fie dat ca input o instructiune in limbajul de asamblare al procesorului aritmetic considerat. Se
cere sa se afiseze la standard output evaluarea instructiunii. Pentru aceasta cerinta, spre deosebire
de cerinta 2, se folosesc variabile introduse prin let.
Un exemplu de input poate fi x 1 let 2 x add y 3 let x y add mul.
Evaluarea va fi facuta astfel:
• se adauga x si 1 pe stiva, este gasit let, si se intelege de acum ca x = 1 in toata expresia
aritmetica; sunt eliminati x si 1 de pe stiva;
• se adauga 2 si 1 pe stiva (deoarece acel x este = 1 de acum);
• se intalneste add, se calculeaza suma 3, se elimina 2 si 1 de pe stiva si se pastreaza doar 3;
• se adauga y si 3 pe stiva, este gasit let, si se intelege de acum ca y = 3 in toata expresia
aritmetica; sunt eliminati y si 3 de pe stiva;
• se adauga 1 si 3 pe stiva (x, respectiv y);
• se efectueaza adunarea, rezultatul va fi 4, se elimina 1 si 3 de pe stiva, se adauga 4;
• este identificat mul, iar pe stiva aveam deja 3 (de la a treia bulinuta din explicatia curenta) si
4, de la bulinuta anterioara, si se calculeaza rezultatul, 12, se elimina apoi 3 si 4 de pe stiva si
se adauga 12;
• nu mai sunt elemente in sir, deci rezultatul final este 12.
Exact ca la cerinta a doua, se garanteaza ca toate operatiile vor fi aplicate pe unsigned.

Cerinta 4:

Pentru aceasta cerinta, vom introduce operatii simple de lucru cu matrice. O matrice poate fi
reprezentata in forma
nrLinii nrColoane nrLinii\*nrColoane_elemente
Operatiile pe care le putem utiliza pe matrice sunt:
• add - adunam toate elementele din matrice cu valoarea operandului;
• sub - scadem din toate elementele din matrice valoarea operandului;
• mul - inmultim toate elementele din matrice cu valoarea operandului;
