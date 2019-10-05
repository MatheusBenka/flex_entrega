import java.util.List;
import java.util.ArrayList;

%%

%{
public class Token {
    public String tipo;
    public String value;
    public Integer line;
    public Integer column;

    public Token(String tipo, String value, Integer line, Integer column) {
        this.tipo = tipo;
        this.value = value;
        this.line = line;
        this.column = column;
    }

    public Token(Linguagem t, String value, Integer line, Integer column) {
        this.tipo = t.Name();
        this.value = value;
        this.line = line;
        this.column = column;
    }
	
	public String getTipo(){
		return tipo;
	}
	public String getValue(){
		return value;
	}
	public Integer getLine(){
		return line;
	}
	public Integer getColumn(){
		return column;
	}

}
%}

%{
public enum Linguagem{
    S_E("E"),
    S_SENAO("SENAO"),
    S_INTEIRO("INTEIRO"),
    S_LEIA("LEIA"),
    S_ESCREVA("ESCREVA"),
    S_INICIO("INICIO"),
    S_FIM("FIM"),
    S_NAO("NAO"),
    S_ENTAO("ENTAO"),
    S_BOOLEANO("BOOLEANO"),
    S_FALSO("FALSO"),
    S_OU("OU"),
    S_VERDADEIRO("VERDADEIRO"),
    S_DIV("DIV"),
    S_FUNCAO("FUNCAO"),
    S_PROCEDIMENTO("PROCEDIMENTO"),
    S_VAR("VAR"),
    S_FACA("FACA"),
    S_SE("SE"),
    S_PROGRAMA("PROGRAMA"),
    S_ENQUANTO("ENQUANTO"),

    IDENTIFICADOR("IDENTIFICADOR"),
    INTEIRO("INTEIRO"),
    IGUAL("IGUAL"),
    SOMA("SOMA"),
    STRING("STRING"),
    PONTO("PONTO"),
    PONTOVIRGULA("PONTO_VIRGULA"),
    VIRGULA("VIRGULA"),
    A_PARENTESES("A_PARENTESES"),
    F_PARENTESES("F_PARENTESES"),
    MAIOR("MAIOR"),
    MAIOR_IGUAL("MAIOR_IGUAL"),
    MENOR("MENOR"),
    MENOR_IGUAL("MENOR_IGUAL"),
    DIF("DIFERENTE"),
    SUB("SUBTRACAO"),
    DOIS_PONTO("DOIS_PONTO"),
    ATRIBUICAO("ATRIBUICAO"),
    MULTI("MULTIPLICACAO");

    private String name;

    private Linguagem(String name){
        this.name = name;
    }

    public String Name(){
        return this.name;
    }
}
%}

%{
private Token createToken(Linguagem t, String value) {
    return new Token( t, value, yyline+1, yycolumn+1);
}
%}

%{
	List<Token> tokens = new ArrayList<>();
%}

%eof{
for(Token t : tokens){
System.out.println("Token - Tipo: " + t.getTipo() + "   Valor: " +
				   t.getValue() + " Linha: " +
				   t.getLine() + " Coluna: " +
				   t.getColumn());
}
%eof}

%public
%class Lexical
%standalone
%line
%column

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment} | {CommentContent}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       =  \{([^}]*)\}

Identifier = [a-zA-Z][a-zA-Z0-9_]*

DecIntegerLiteral = 0 | [1-9][0-9]*
String               = \"[^\"]*\"
%%

"programa"                      { tokens.add(createToken(Linguagem.S_PROGRAMA, yytext())); }
"inicio"                        { tokens.add(createToken(Linguagem.S_INICIO, yytext())); }
"fim"                           { tokens.add(createToken(Linguagem.S_FIM, yytext())); }
"procedimento"                  { tokens.add(createToken(Linguagem.S_PROCEDIMENTO, yytext())); }
"funcao"                        { tokens.add(createToken(Linguagem.S_FUNCAO, yytext())); }
"se"                            { tokens.add(createToken(Linguagem.S_SE, yytext())); }
"entao"                         { tokens.add(createToken(Linguagem.S_ENTAO, yytext())); }
"senao"                         { tokens.add(createToken(Linguagem.S_SENAO, yytext())); }
"enquanto"                      { tokens.add(createToken(Linguagem.S_ENQUANTO, yytext())); }
"faca"                          { tokens.add(createToken(Linguagem.S_FACA, yytext())); }
"escreva"                       { tokens.add(createToken(Linguagem.S_ESCREVA, yytext())); }
"leia"                          { tokens.add(createToken(Linguagem.S_LEIA, yytext())); }
"var"                           { tokens.add(createToken(Linguagem.S_VAR, yytext())); }
"inteiro"                       { tokens.add(createToken(Linguagem.S_INTEIRO, yytext())); }
"booleano"                      { tokens.add(createToken(Linguagem.S_BOOLEANO, yytext())); }
"div"                           { tokens.add(createToken(Linguagem.S_DIV, yytext())); }
"e"                             { tokens.add(createToken(Linguagem.S_E, yytext())); }
"ou"                            { tokens.add(createToken(Linguagem.S_OU, yytext())); }
"nao"                           { tokens.add(createToken(Linguagem.S_NAO, yytext())); }
"falso"                         { tokens.add(createToken(Linguagem.S_FALSO, yytext())); }
"verdadeiro"                    { tokens.add(createToken(Linguagem.S_VERDADEIRO, yytext())); }

{String}                                { tokens.add(createToken(Linguagem.STRING,yytext()));  }
{Identifier}                            { tokens.add(createToken(Linguagem.IDENTIFICADOR,yytext())); }
{DecIntegerLiteral}                     { tokens.add(createToken(Linguagem.INTEIRO,yytext())); }
"="                                     { tokens.add(createToken(Linguagem.IGUAL,yytext())); }
"+"                                     { tokens.add(createToken(Linguagem.SOMA,yytext())); }
"."                                     { tokens.add(createToken(Linguagem.PONTO, yytext())); }
":="                                    { tokens.add(createToken(Linguagem.ATRIBUICAO, yytext())); }
";"                                     { tokens.add(createToken(Linguagem.PONTOVIRGULA, yytext())); }
","                                     { tokens.add(createToken(Linguagem.VIRGULA, yytext())); }
"("                                     { tokens.add(createToken(Linguagem.A_PARENTESES, yytext())); }
")"                                     { tokens.add(createToken(Linguagem.F_PARENTESES, yytext())); }
">"                                     { tokens.add(createToken(Linguagem.MAIOR, yytext())); }
">="                                    { tokens.add(createToken(Linguagem.MAIOR_IGUAL, yytext())); }
"<"                                     { tokens.add(createToken(Linguagem.MENOR, yytext())); }
"<="                                    { tokens.add(createToken(Linguagem.MENOR_IGUAL, yytext())); }
"<>"                                    { tokens.add(createToken(Linguagem.DIF, yytext())); }
"-"                                     { tokens.add(createToken(Linguagem.SUB, yytext())); }
"*"                                     { tokens.add(createToken(Linguagem.MULTI, yytext())); }
":"                                     { tokens.add(createToken(Linguagem.DOIS_PONTO, yytext())); }
{Comment}                               { }
{WhiteSpace}                            { }


. { throw new RuntimeException("\nErro encontrado\nlinha : " + yyline + "\ncoluna : "+yycolumn+"\ncaracter : "+yytext() ); }