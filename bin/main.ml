let () =
    let lexbuf = Lexing.from_string "1 pop\n2 print\n3 push 10"
    in let result = Stacklang.Parser.lines Stacklang.Lexer.token lexbuf
    in List.iter (fun a -> print_endline (Stacklang.Syntax.string_of_line a)) result
