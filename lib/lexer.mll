{
    open Parser
}

rule token = parse
    | [' ' '\t']             { token lexbuf }
    | ['\n']                 { EOL }
    | eof                    { EOF }
    | '-'? ['0'-'9']+ as lxm { NUM (int_of_string lxm) }
    | "push"                 { PUSH }
    | "pop"                  { POP }
    | "add"                  { ADD }
    | "ifeq"                 { IFEQ }
    | "jump"                 { JUMP }
    | "print"                { PRINT }
    | "dup"                  { DUP }
