open Stacklang.Syntax

let env = Stack.create ()

let () =
    let lexbuf = Lexing.from_string "10 push 1\n20 push 2\n30 add\n40 print"
    in let result = Stacklang.Parser.lines Stacklang.Lexer.token lexbuf
    in List.iter (fun line -> Stacklang.Eval.eval env line.inst) result
