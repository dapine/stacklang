open Stacklang.Syntax
open Stacklang.Eval

let lexbuf = Lexing.from_string "10 push 1\n20 push -1\n30 add\n40 print\n50 ifeq 40\n 60 dup\n70 print\n80 push 1\n90 print"

let parse lexbuf = Stacklang.Parser.lines Stacklang.Lexer.token lexbuf

let createTable lines = let tbl = IntHashtbl.create (List.length lines)
                        in List.iter (fun a -> IntHashtbl.add tbl a.addr a.inst) lines; tbl

let () =
    let parsed = parse lexbuf
    in let tbl = createTable parsed
    in let env = { stack=Stack.create () ; lines=tbl }
    in List.iter (fun line -> Stacklang.Eval.eval env line.inst) parsed
