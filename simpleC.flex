import java_cup.runtime.*;

%%

%public
%class Scanner
%implements sym

%line
%column

%cup
%cupdebug

%{
  StringBuffer string = new StringBuffer();
  
  private Symbol symbol(int type) {
    return new MySymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new MySymbol(type, yyline+1, yycolumn+1, value);
  }
%}

/* White spaces */
WhiteSpace = [ \t\f\r\n]

/* Comments in C files: no need to worry about them: assume the C
 * preprocessor was already executed - it strips away comments 
 */
//Identifiernondigit=[_a-zA-Z]
//Digit = [0-9]
Identifier = [_a-zA-Z][_a-zA-Z0-9]*



//Nonzerodigit=[1-9]
//Decimalconstant = [1-9][0-9]*



//Octaldigit = [0-7]
//Octalconstant = 0[0-7]*


//Hexadecimalprefix = 0[xX]
//Hexadecimaldigit =[0-9a-fA-F]



//(Hexadecimalprefix)(Hexadecimaldigit)+

Hexadecimalconstant = 0[xX][0-9a-fA-F]+

//I am not sure about this.
Integersuffix = [uU][lL]? | [lL][uU]?

//DecIntegerLiteral = Decimalconstant (Integersuffix)? | Octalconstant (Integersuffix)? | Hexadecimalconstant (Integersuffix)?
//I am not sure about this.
DecIntegerLiteral = [1-9][0-9]* ( [uU][lL]? | [lL][uU]? )? | 0[0-7]* ([uU][lL]? | [lL][uU]?)? | 0[xX][0-9a-fA-F]+ ( [uU][lL]? | [lL][uU]? )?






//Sign = [-+]
//Digitsequence = [0-9]+


//Fractionalconstant=Digitsequence?(.)Digitsequence| Digitsequence(.)

//I am not clear about whether I can use ()?
Fractionalconstant=([0-9]+)?\.[0-9]+| [0-9]+\.


//Exponentpart = (e|E)Sign? Digitsequence
Exponentpart = [eE][+-]? [0-9]+

//Binaryexponentpart=(p|P) (Sign)?Digitsequence
//Binaryexponentpart=[pP] [-+]?[0-9]+



//Hexadecimaldigit =[0-9a-fA-F]
//Hexadecimaldigitsequence=[0-9a-fA-F]+



//Hexadecimalfractionalconstant=(Hexadecimaldigitsequence)?(.)Hexadecimaldigitsequence|Hexadecimaldigitsequence(.)
//I do not know  whether I can use ()
Hexadecimalfractionalconstant=([0-9a-fA-F]+)?\.[0-9a-fA-F]+|[0-9a-fA-F]+\.





//Floatingsuffix=[fFlL]


//Decimalfloatingconstant=(Fractionalconstant)(Exponentpart)?(Floatingsuffix)?|Digitsequence(Exponentpart)Floatingsuffix?
//Not clear


Decimalfloatingconstant=(([0-9]+)?\.[0-9]+| [0-9]+\.)( [eE][+-]? [0-9]+ )?[fFlL]?|[0-9]+ [eE][+-]?[0-9]+ [fFlL]?


//Hexadecimalfloatingconstant=(Hexadecimalprefix)(Hexadecimalfractionalconstant)(Binaryexponentpart)(Floatingsuffix)?|(Hexadecimalprefix)(Hexadecimaldigitsequence)binary-exponent-part floating-suffixopt
Hexadecimalfloatingconstant=0[xX](([0-9a-fA-F]+)?\.[0-9a-fA-F]+|[0-9a-fA-F]+\.)([pP] [-+]?[0-9]+)[fFlL]?|0[xX][0-9a-fA-F]+([pP] [-+]?[0-9]+)[fFlL]?

//DoubleLiteral  = Decimalfloatingconstant|Hexadecimalfloatingconstant
DoubleLiteral  = ((([0-9]+)?\.[0-9]+| [0-9]+\.)( [eE][+-]? [0-9]+ )?[fFlL]?|[0-9]+ [eE][+-]?[0-9]+ [fFlL]? ) |  ( 0[xX](([0-9a-fA-F]+)?\.[0-9a-fA-F]+|[0-9a-fA-F]+\.)([pP] [-+]?[0-9]+)[fFlL]?|0[xX][0-9a-fA-F]+([pP] [-+]?[0-9]+)[fFlL]?)

%%

<YYINITIAL> {

  "auto"                         { return symbol(AUTO);}
  "break"                        { return symbol(BREAK);}
  "case"                          {return symbol(CASE);}
  "char"                          {return symbol(CHAR);}
  "const"                         {return symbol(CONST);}
  "continue"                      {return symbol(CONTINUE);}
    "default"                         { return symbol(DEFAULT);}
  "do"                         { return symbol(DO);}
  "double"                        { return symbol(DOUBLE);}
  "else"                          {return symbol(ELSE);}
  "enum"                          {return symbol(ENUM);}
  "extern"                         {return symbol(EXTERN);}
  "float"                      {return symbol(FLOAT);}
  "for"                          { return symbol(FOR); }
  "goto"                         { return symbol(GOTO);}
  "if"                        { return symbol(IF);}
  "inline"                          {return symbol(INLINE);}
  "int"                          {return symbol(INT);}
  "long"                         {return symbol(LONG);}
  "register"                      {return symbol(REGISTER);}
  "restrict"                         { return symbol(RESTRICT);}
  "return"                        { return symbol(RETURN);}
  "short"                          {return symbol(SHORT);}
  "signed"                          {return symbol(SIGNED);}
  "sizeof"                         {return symbol(SIZEOF);}
  "static"                      {return symbol(STATIC);}
  "struct"                          { return symbol(STRUCT); }
   "switch"                         {return symbol(SWITCH);}
  "typedef"                      {return symbol(TYPEDEF);}
  "union"                          { return symbol(UNION); }
  "unsigned"                          {return symbol(UNSIGNED);}
  "void"                          {return symbol(VOID);}
  "volatile"                         {return symbol(VOLATILE);}
  "while"                      {return symbol(WHILE);}


  /* I  am not clear about these three*/
  "_Bool"                          { return symbol(_BOOL); }
   "_Complex"                         {return symbol(_COMPLEX);}
  "_Imaginary"                      {return symbol(_IMAGINARY);}

  
  /* Punctuators: TODO - add all punctuators from Section 6.4.6 except
  for the last eight punctuators */

"["                            { return symbol(LBRACK); }
  "]"                            { return symbol(RBRACK); }
  "("                            { return symbol(LPAREN); }
  ")"                            { return symbol(RPAREN); }
  "{"                            { return symbol(LBRACE); }
  "}"                            { return symbol(RBRACE); }


  /* I am not clear about the names of these two*/
    "."                            { return symbol(DOT); }
     "->"                            { return symbol(POINTER); }


      "++"                           { return symbol(PLUSPLUS); }


      //I am not clear about the name of these two
        "--"                            { return symbol(MINUSMINUS); }
        "&"                            { return symbol(YU); }


         "*"                            { return symbol(STAR); }
           "+"                            { return symbol(PLUS); }
          "-"                            { return symbol(MINUS); }

/*I am not clear about these two */
           "~"                            { return symbol(FEI); }
           "!"                            { return symbol(GANTANHAO); }
  
 
   "/"                            { return symbol(DIV); }




   /* Not clear about the following three*/
    "%"                            { return symbol(SHANG); }
    "<<"                            { return symbol(ZUOYI); }
    ">>"                            { return symbol(YOUYI); }






     "<"                            { return symbol(LT); }




/* Not clear about the following 11*/
    ">"                            { return symbol(GT); }
    "<="                            { return symbol(LTE); }
     ">="                            { return symbol(GTE); }
     "=="                            { return symbol(EQL); }
    "!="                            { return symbol(NE); }
    "^"                            { return symbol(XIAOFEI); }
"|"                            { return symbol(HUO); }
"&&"                            { return symbol(LUOJIYU); }
"||"                            { return symbol(LUOJIHUO); }
"?"                            { return symbol(WENHAO); }
":"                            { return symbol(MAOHAO); }






  ";"                            { return symbol(SEMICOLON); }



/*NOT Clear about the following one*/
"..."                            { return symbol(SANDIAN); }




  "="                            { return symbol(ASSGN); }


  /*not clear about  the following */
    "*="                            { return symbol(CHENGYIDENGYU); }
    "/="                            { return symbol(CHUYIDENGYU); }
  "%="                            { return symbol(SHANGDENGYU); }
  "+="                            { return symbol(JIADENGYU); }
   "-="                            { return symbol(JIANDENGYU); }
 "<<="                            { return symbol(ZUOYIDENGYU); }
  ">>="                            { return symbol(YOUYIDENGYU); }
  "&="                            { return symbol(YUDENGYU); }
  "^="                            { return symbol(FEIDENGYU); }
  "|="                            { return symbol(HUODENGYU); }




  ","                            { return symbol(COMMA); }


  /*not clear about  the following */
  "#"                            { return symbol(JINGHAO); }
  "##"                            { return symbol(SHUANGJING); }


  /* replace this placeholder with your own definitions */
  {DecIntegerLiteral}            {

  char first_char = yycharat(0);
  char last_char = yycharat(yylength()-1);

  char second_char;
  char second_last;

  if(yylength()>1){

    second_char = yycharat(1);
    second_last = yycharat(yylength()-1);
   }

   if((last_char == 'L') ||(last_char == 'l')){

    String input = yytext().substring(0, yylength()-1);

    int len = input.length();

    if((input.charAt(len-1) == 'u') || (input.charAt(len-1) == 'U')){
        input = input.substring(0, len-1);
    }


    long dec_int;

      if(first_char == '0'){
        if(input.length() == 1){
            dec_int = 0;
        }
        else{
            char sec = input.charAt(1);
            if((sec == 'X')||( sec == 'x')){
                String hex = input.substring(2);
                dec_int = Long.parseLong(hex, 16);
             }
            else
            {
                String oct = input.substring(1);
                dec_int = Long.parseLong(oct, 8);
            }
        }
    }
    else{
        dec_int = Long.parseLong( input);
    }
    return symbol(INTEGER_LITERAL, new Long(dec_int));
  }
  else{

    String input;
    if((last_char == 'u') ||(last_char == 'U')){
         input = yytext().substring(0, yylength()-1);
    }
    else{
        input = yytext();
    }

    int len = input.length();
    char new_last = input.charAt(len-1);




    if( (new_last == 'l') || (new_last == 'L')){
        long dec_int;
        input = yytext().substring(0, len-1);

        if(first_char == '0'){
                if(input.length() == 1){
                 dec_int = 0;
                }
                else{
                    char sec = input.charAt(1);
                    if((sec == 'X')||( sec == 'x')){
                        String hex = input.substring(2);
                        dec_int = Long.parseLong(hex, 16);
                    }
                    else
                    {
                        String oct = input.substring(1);
                        dec_int = Long.parseLong(oct, 8);
                    }
                }
            }
            else{
                dec_int = Long.parseLong( input);
            }
            return symbol(INTEGER_LITERAL, new Long(dec_int));
    }
    else{
        int dec_int;
        if(first_char == '0'){
            if(input.length() == 1){
             dec_int = 0;
            }
            else{
                char sec = input.charAt(1);
                if((sec == 'X')||( sec == 'x')){
                    String hex = input.substring(2);
                    dec_int = Integer.parseInt(hex, 16);
                }
                else
                {
                    String oct = input.substring(1);
                    dec_int = Integer.parseInt(oct, 8);
                }
            }
        }
        else{
            dec_int = Integer.parseInt( input);
        }
        return symbol(INTEGER_LITERAL, new Integer(dec_int));

    }

  }
}



  /* replace this placeholder with your own definitions */
  {DoubleLiteral}                { 
    char last_char = yycharat(yylength()-1);
    if((last_char == 'f') ||(last_char == 'F')){
      return symbol(FLOATING_POINT_LITERAL, new Float(yytext())); 
    }
    else{
     return symbol(FLOATING_POINT_LITERAL, new Double(yytext()));
      }
    }
    
  
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */ 
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }  
}

/* error fallback */
.|\n                             { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+(yyline+1)+", column "+(yycolumn+1)); }
<<EOF>>                          { return symbol(EOF); }
