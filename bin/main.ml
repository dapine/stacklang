let usage = "Usage: stacklang help -> shows this message
       stacklang repl -> starts a REPL session
       stacklang [file] -> interprets the code from file"

let show_usage () =
    print_endline usage

let () =
    if Array.length Sys.argv > 1
    then match Sys.argv.(1) with
            | "help" -> show_usage ()
            | "repl" -> Stacklang.Interpreter.repl ()
            | _ -> Stacklang.Interpreter.from_file Sys.argv.(1)
    else show_usage ()
