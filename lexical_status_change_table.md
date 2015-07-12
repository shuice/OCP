|From		| Input		| To		| Output 	|Action|
|: -------:	|:-------	|:-----:	|:------	||
|1			|\r\t\n\b	|1			|Identify	||
|1			|{};.()+_*	|1 			|Identify	||
|1			|/			|4 			|			||
|1			|&			|6			|			||
|1			|"			|9			|			||
|1			|0			|11			|			||
|1			|[1-9]		|13			|			||
|1			|[a-zA-z\_]	|15			|			||
|1			|EOF		|			|End		||
|1			|\|			|7			|			||
|1			|<>=		|8			|			||
|4			|/			|5			|			||
|4			|[0-9a-zA-z\_](\r\t\n\bEOF|1|Identify|Pop|
|5			|\nEOF		|1			|Comment	|Pop
|5			|^(\nEOF)	|5			|			||
|6			|&			|1			|Identify Op||
|7			|\|			|1			|Identify Op||
|8			|=			|1			|Identify Op||
|8			|^=			|1			|Identify Op|Pop|
|9			|\\			|10			|			||
|9			|^(\\EOF)	|9			|			|
|9			|"			|1			|String		||
|10			|rbtn		|9			|			||
|11			|<>=\|&;\r\b\t\nEOF|1	|Number		|Pop|
|11			|.			|12			|			||
|11			|^(<>=\|&;\r\b\t\nEOF.)||			|Err|
|12			|<>=\|&;\r\b\t\nEOF|1	|Number		|Pop|
|13			|[1-9]		|13			|			||
|13			|<>=\|&;\r\b\t\nEOF|	|Number		|Pop|
|13			|.			|14			|			||
|14			|[0-9]		|14			|			||
|14			|<>=\|&;\r\b\t\nEOF|	|Number		|Pop|
|15			|<>=\|&;\r\b\t\nEOF|	|Identify	|Pop|


