package jflex;

import java_cup.runtime.Symbol;
%%

%unicode
%class Lexer
%cup
%implements sym 

%line
%column
 
%{
private Symbol symbol(int sym) {
    return new Symbol(sym, yyline+1, yycolumn+1);
}
  
private Symbol symbol(int sym, Object val) {
   return new Symbol(sym, yyline+1, yycolumn+1, val);
}

private void error(String message) {
   System.out.println("Error at line "+ (yyline+1) + ", column " + (yycolumn+ 1)+ " : "+message);
}
%} 

LineEnd = [\r\n]|\r\n
Character = [^\r\n]
WhiteSpace = {LineEnd} | [ \t\f]
 
LineComment = "//" {Character}* {LineEnd}
CStyleComment = "/*" ~"*/" 
Comment = {LineComment} | {CStyleComment}

 
Name = [a-zA-Z][a-zA-Z0-9_]*
Qchar = "\'"."\'"
String = "\"" ~"\""
Number = [0-9]+
 
%%
<YYINITIAL> {
   
   /* Arithmetic Operations */
   "-" { return symbol(SUB);}
   "+" { return symbol(ADD); }
   "*" { return symbol(MULT); }
   "/" { return symbol(DIV); }
 
   "<" { return symbol(LT); }
   ">" { return symbol(GT); }
   "!" { return symbol(NOT); }
   "=" { return symbol(EQL); }
   "==" { return symbol(DEQL); }
   "!=" { return symbol(NEQL); }
   ";" { return symbol(SEMI); }
   "," { return symbol(COMMA); }
   
   /* Keywords */
   "read" 	 { return symbol(READ); }
   "write" 	 { return symbol(WRITE); }
   "int"     { return symbol(INT); }
   "char"    { return symbol(CHAR); }
   "length"  { return symbol(LENGTH); }
   "tiny"    { return symbol(MAIN); }
   "if" 	 { return symbol(IF); }
   "else"    { return symbol(ELSE); }
   "while"   { return symbol(WHILE); }
   "return"  { return symbol(RETURN); }
 
   "(" { return symbol(LPAREN); }
   ")" { return symbol(RPAREN); }
   "[" { return symbol(LSQBKT); }
   "]" { return symbol(RSQBKT); }
   "{" { return symbol(LBRKT); }
   "}" { return symbol(RBRKT); }
   
   {Comment} {}
   {Qchar}  { return symbol(QCHAR, yycharat(1)); }
   {Name} { return symbol(ID, yytext());}
   {Number} { return symbol(NUMERIC_CONSTANT, new Integer(Integer.parseInt(yytext()))); }
   {WhiteSpace} { /* Ignore */ }
 
 }
 
.|\n { System.out.println("ERROR");error(yytext());}