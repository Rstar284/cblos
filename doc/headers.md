# CBLOS' Standard for Headers
The standard that CBLOS sets for headers is very easy to follow

## Example
Let's say we have 2 files, `include/foo.h`, and `main.c`

*main.c:*
```c
#include "include/foo.h"

void main() {
    Foo f;
    f.foo();
}
```

*include/foo.h:*
```c
#pragma once

#ifndef FOO
#define FOO

class Foo {
    public:
        void foo();
};

#endif // FOO
```

You must create a file (in this case) named `include/foo.c`, and
fill its contents with the definitions of the prototypes set in
`foo.h`.

*include/foo.c:*
```c
#include <stdio.h>
#include "foo.h"

void Foo::foo() {
    printf("Hello world!\n");
}
```

## Why would we do this?
This is to un-clot the header file, per say.

> *Only put your functions in a header if you'd like those functions available to anyone who includes the header.*

\- [Stack Overflow](https://stackoverflow.com/questions/50602755/functions-declared-and-defined-in-a-c-file)