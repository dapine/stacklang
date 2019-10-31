# stacklang

A simple interpreter based on [this StackOverflow answer](https://stackoverflow.com/questions/6887471/how-would-i-go-about-writing-an-interpreter-in-c/6888074#6888074).

This language has a very similar concept to assembly languages, computation is made by running instructions and changing the state by addding and pooping items from a stack.

The general instruction format is something like this: `(address) instruction (argument)`. Where `address` and `argument` are integer numbers and `argument` is required in some instructions.

**Instructions**
```
push <num>            pushes <num> to the stack
pop                   pops value from top of the stack
add                   sums the two topmost numbers from stack
jump <addr>           jumps to given <addr>, executing its instruction
ifeq <addr>           jumps to <addr> when the top of stack is not 0
dup                   duplicate value from top of stack
print                 prints the top of the stack
```

e.g.

```
sl> 1 push 99      
sl> 2 push 1
sl> 3 add
sl> 4 print
>>> 100
```

**Installation**

You'll need an OCaml environment with dune build system
```
dune build bin/main.exe
dune exec bin/main.exe
```
