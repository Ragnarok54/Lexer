package jflex;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java_cup.runtime.Symbol;

public class main {
	static HashMap<Integer, String> tokenClass = new HashMap<Integer, String> (); 
	
	public static void initHash()
	{
		for (var symbol = sym.SUB; symbol <= sym.NEQL; symbol++) {
			tokenClass.put(symbol, "Operator");
		}
		
		tokenClass.put(sym.SEMI, "Delimiter");
		tokenClass.put(sym.COMMA, "Delimiter");

		for (var symbol = sym.READ; symbol <= sym.RETURN; symbol++) {
			tokenClass.put(symbol, "Keyword");
		}
		
		for (var symbol = sym.LPAREN; symbol <= sym.RBRKT; symbol++) {
			tokenClass.put(symbol, "Parentheses");
		}
		
		tokenClass.put(sym.ID, "Identifier");
		tokenClass.replace(sym.NUMERIC_CONSTANT, "Number");
		tokenClass.replace(sym.QCHAR, "Qchar");
	}

	public static void main (String[] args) {
		
		main.initHash();
		
		FileReader inputFile;
		try {
			inputFile = new FileReader("tiny.java");
			BufferedReader br = new BufferedReader(inputFile);
			Lexer l = new Lexer (br);
			
			try {
				Symbol sCrt;
				do 
				{
					sCrt = l.next_token();
										
					if (sCrt.sym != sym.EOF)
					{
						System.out.println("Symbol value: "+ l.yytext() + " Class: " + main.tokenClass.get(sCrt.sym) + " line: " + sCrt.left + " column: " + sCrt.right);
					}
				}while(sCrt.sym != sym.EOF);
				System.out.println("EOF");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
	}

}

