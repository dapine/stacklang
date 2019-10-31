open Eval

let run () =
    let tbl = IntHashtbl.create 1
    in let env = { stack=Stack.create () ; lines=tbl }
    in while true do
        Printf.printf "sl> %!";
        let lexbuf = Lexing.from_string (read_line ())
        in let parsed = Parser.line Lexer.token lexbuf
        in if IntHashtbl.mem tbl parsed.addr
           then print_endline "Eval error: Address already in use"
           else (match Eval.eval env parsed.inst with
                    | Ok _ -> IntHashtbl.add tbl parsed.addr parsed.inst
                    | Error e -> print_endline e)
    done
