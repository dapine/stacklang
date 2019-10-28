let rec eval env = function
    | Syntax.Push n -> Stack.push n env
    | Syntax.Pop -> (match (Stack.pop_opt env) with
                        | None -> print_endline "Eval error: Could not pop from stack"
                        | _ -> ())
    | Syntax.Add -> if Stack.length env > 1
                    then let fst = Stack.pop env
                         in let snd = Stack.pop env
                         in let sum = fst + snd
                         in (eval env (Syntax.Push sum))
                    else ()
    | Syntax.Print -> (match Stack.top_opt env with
                        | None -> print_endline "Eval error: Could not print from stack. It might be empty?"
                        | Some n -> print_endline (">> " ^ (string_of_int n)))
    | Syntax.Dup -> (match Stack.top_opt env with
                        | None -> print_endline "Eval error: Could not dup from stack. It might be empty?"
                        | Some n -> Stack.push n env)

    | _ -> print_endline "Eval error: Instruction not implemented"
