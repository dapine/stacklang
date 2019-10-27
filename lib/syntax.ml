type address = int

type instruction =
    | Push of int
    | Pop
    | Add
    | Ifeq of address
    | Jump of address
    | Print
    | Dup

type line = { addr: address ; inst: instruction }

let string_of_instruction = function
    | Push n -> "push " ^ string_of_int n
    | Pop -> "pop"
    | Add -> "add"
    | Ifeq addr -> "ifeq " ^ string_of_int addr
    | Jump addr -> "jump " ^ string_of_int addr
    | Print -> "print"
    | Dup -> "dup"

let string_of_address addr = string_of_int addr

let string_of_line l = string_of_address l.addr ^ " " ^ string_of_instruction l.inst
