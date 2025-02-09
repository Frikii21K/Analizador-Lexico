%%
%class Lexer
%unicode
%public
%function tokenize
%type String
%line
%column
%{
    // StringBuilder para acumular la salida de tokens
    StringBuilder tokens = new StringBuilder();

    // Método auxiliar para agregar tokens de forma uniforme
    private void addToken(String token, String lexeme) {
        tokens.append(token).append(" : ").append(lexeme)
              .append(" [línea ").append(yyline + 1)
              .append(", columna ").append(yycolumn + 1).append("]\n");
    }
%}

%%

// Palabras reservadas
"if"          { addToken("PALABRA_RESERVADA", yytext()); }
"else"        { addToken("PALABRA_RESERVADA", yytext()); }
"while"       { addToken("PALABRA_RESERVADA", yytext()); }
"for"         { addToken("PALABRA_RESERVADA", yytext()); }
"return"      { addToken("PALABRA_RESERVADA", yytext()); }
"int"         { addToken("PALABRA_RESERVADA", yytext()); }
"float"       { addToken("PALABRA_RESERVADA", yytext()); }
"double"      { addToken("PALABRA_RESERVADA", yytext()); }
"char"        { addToken("PALABRA_RESERVADA", yytext()); }
"boolean"     { addToken("PALABRA_RESERVADA", yytext()); }

// Operadores aritméticos y relacionales
"=="          { addToken("OPERADOR_IGUALDAD", yytext()); }
"!="          { addToken("OPERADOR_DIFERENTE", yytext()); }
"<="          { addToken("OPERADOR_MENOR_IGUAL", yytext()); }
">="          { addToken("OPERADOR_MAYOR_IGUAL", yytext()); }
"<"           { addToken("OPERADOR_MENOR", yytext()); }
">"           { addToken("OPERADOR_MAYOR", yytext()); }
"="           { addToken("OPERADOR_ASIGNACION", yytext()); }
"+"           { addToken("OPERADOR_SUMA", yytext()); }
"-"           { addToken("OPERADOR_RESTA", yytext()); }
"*"           { addToken("OPERADOR_MULTIPLICACION", yytext()); }
"/"           { addToken("OPERADOR_DIVISION", yytext()); }

// Delimitadores y puntuación
"("           { addToken("PARENTESIS_IZQUIERDO", yytext()); }
")"           { addToken("PARENTESIS_DERECHO", yytext()); }
"{"           { addToken("LLAVE_IZQUIERDA", yytext()); }
"}"           { addToken("LLAVE_DERECHA", yytext()); }
";"           { addToken("PUNTO_Y_COMA", yytext()); }
","           { addToken("COMA", yytext()); }

// Números (enteros y flotantes)
[0-9]+(\.[0-9]+)?  { addToken("NUMERO", yytext()); }

// Literales de cadena
\"([^\\\"]|\\.)*\"  { addToken("CADENA", yytext()); }

// Comentarios de una línea (se ignoran)
"//".*        { /* No se agrega token, se ignora el comentario */ }

// Comentarios multilínea (se ignoran)
"/*"([^*]|(\*+[^*/]))*\*+ "/"  { /* Ignorar comentarios multilínea */ }

// Identificadores
[a-zA-Z_][a-zA-Z0-9_]* { addToken("IDENTIFICADOR", yytext()); }

// Espacios en blanco (se ignoran)
[ \t\n\r]+   { /* Ignorar espacios */ }

// Cualquier otro caracter no reconocido
.             { addToken("DESCONOCIDO", yytext()); }

<<EOF>>       { return tokens.toString(); }
