%{
%}

%token <int> NUM
%token EOL EOF
%token PUSH POP ADD IFEQ JUMP PRINT DUP

%start lines
%start line
%type <Syntax.line list> lines
%type <Syntax.instruction> inst
%type <Syntax.line> line

%%

inst:
    | PUSH NUM { Syntax.Push $2 }
    | POP { Syntax.Pop }
    | ADD { Syntax.Add }
    | IFEQ NUM { Syntax.Ifeq $2 }
    | JUMP NUM { Syntax.Jump $2 }
    | PRINT { Syntax.Print }
    | DUP { Syntax.Dup }
;

line: NUM inst { { addr = $1; inst = $2 } : Syntax.line }
;

lines_:
    | line { [$1] }
    | lines_ EOL line { $3 :: $1 }
;

lines: lines_ EOF { List.rev $1 }
;
