module IntHash =
    struct
        type t = int
        let equal i j = i=j
        let hash i = i land max_int
    end

module IntHashtbl = Hashtbl.Make(IntHash)

type environment = { stack: int Stack.t ; lines: Syntax.instruction Hashtbl.Make(IntHash).t }

let rec eval env = function
    | Syntax.Push n -> Stack.push n env.stack
    | Syntax.Pop -> (match (Stack.pop_opt env.stack) with
                        | None -> print_endline "Eval error (pop): Could not pop from stack"
                        | _ -> ())
    | Syntax.Add -> if Stack.length env.stack > 1
                    then let fst = Stack.pop env.stack
                         in let snd = Stack.pop env.stack
                         in let sum = fst + snd
                         in (eval env (Syntax.Push sum))
                    else ()
    | Syntax.Print -> (match Stack.top_opt env.stack with
                        | None -> print_endline "Eval error (print): Could not print from stack. It might be empty?"
                        | Some n -> print_endline (">>> " ^ (string_of_int n)))
    | Syntax.Dup -> (match Stack.top_opt env.stack with
                        | None -> print_endline "Eval error (dup): Could not dup from stack. It might be empty?"
                        | Some n -> Stack.push n env.stack)

    | Syntax.Jump addr -> (match IntHashtbl.find_opt env.lines addr with
                            | None -> print_endline ("Eval error (jump): Could not find the address " ^ string_of_int addr)
                            | Some inst -> eval env inst)
    | Syntax.Ifeq addr -> (match Stack.top_opt env.stack with
                            | None -> print_endline "Eval error (ifeq): Stack is empty"
                            | Some n -> if n = 0
                                        then ()
                                        else eval env (Syntax.Jump addr))
