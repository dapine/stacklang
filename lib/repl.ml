open Eval

let run () =
    let tbl = IntHashtbl.create 1
    in let env = { stack=Stack.create () ; lines=tbl }
    in while true do
        Printf.printf "sl> %!";
        let lexbuf = Lexing.from_string (read_line ())
        in let parsed = Parser.line Lexer.token lexbuf
        in Eval.eval env parsed.inst;
        IntHashtbl.add tbl parsed.addr parsed.inst
    done
