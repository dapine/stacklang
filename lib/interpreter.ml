open Eval
open Syntax

let interpret env line =
    if IntHashtbl.mem env.lines line.addr
    then print_endline "Eval error: Address already in use"
    else (match Eval.eval env line.inst with
            | Ok _ -> IntHashtbl.add env.lines line.addr line.inst
            | Error e -> print_endline e)

let from_file filename =
    let tbl = IntHashtbl.create 1
    in let env = { stack=Stack.create () ; lines=tbl }
    in let lexbuf = Lexing.from_channel (open_in filename)
    in let parsed = Parser.lines Lexer.token lexbuf
    in List.iter (fun l -> interpret env l) parsed

let repl () =
    let tbl = IntHashtbl.create 1
    in let env = { stack=Stack.create () ; lines=tbl }
    in while true do
        Printf.printf "sl> %!";
        let lexbuf = Lexing.from_string (read_line ())
        in let parsed = Parser.line Lexer.token lexbuf
        in interpret env parsed
    done
