open Eval
open Syntax

let run () =
    let tbl = IntHashtbl.create 1
    in let env = { stack=Stack.create () ; lines=tbl }
    in let lexbuf = Lexing.from_channel (open_in "example.sl")
    in let parsed = Parser.lines Lexer.token lexbuf
    in List.iter (fun l -> match eval env l.inst with
                                | Ok _ -> IntHashtbl.add env.lines l.addr l.inst
                                | Error e -> print_endline e) parsed
