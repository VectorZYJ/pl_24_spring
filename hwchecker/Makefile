yz10317.hwchecker:
	bison -d yz10317.hwchecker.y
	flex yz10317.hwchecker.l
	g++ lex.yy.c yz10317.hwchecker.tab.c -o hw-checker
	rm lex.yy.c yz10317.hwchecker.tab.c yz10317.hwchecker.tab.h
