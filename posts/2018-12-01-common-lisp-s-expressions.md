---
title: Common Lisp - S-expressions

date: 2018-12-02
tags: common lisp, lisp
---
# S-expressions

Exist two basics elements of an s-expressions: *lists* and *atoms*. To define a list we use
parenteses, with any number of elements separated by whitespace.

```lisp
(1 2 3 4 5)
```

By other hand, *atoms* are everything else. There is a exception for it: a empty list `()` also written as `NIL` is both, an list and a atom. So the elements of the list, `1, 2, 3, 4` and `5` are s-expressions, so bassicaly atoms and nested lists.

There also the comments, they aren't considered s-expressions, they start with a semicolumn, and the compiler treat is bassicaly like whitespaces.

In the rest of this post, lets see the most commonly used kinds of atoms, they are:

- numbers
- strings, and
- names

# Numbers

Numebrs are straightfoward, so, any sequecence of digits, can include the sign `+` or `-`, the decimal point (`.`) or the [solidus](https://en.wikipedia.org/wiki/Slash_(punctuation)) (`/`), examples:

* 123 ; integer one hundred twenty-three
* 3/7 ; the ratio three-sevenths
* 2.0 ; the floating-point number two in default precision
* 2.0e0 ; another way to write the same foating-point number
* 2.0d0 ; the floating-point number two in 'double' precision
* 1.Oe-4 ; the floating-point equivalent to one-thenn-thousandth
* +41 ; the integer forty-one
* -10 ; the integer negative ten
* -1/4 ; the ratio negative one-quarter
* -2/8 ; another way to represent negative one-quater


These examples respresente many different numebrs: integers, rations, and floating point. Lisp also provide support for complex numbers, lets discuss it in other post.

So, as you can see, there is different forms to represent same numbers, but internally they are the same objects.

# Strings

Strings literal, are represented as in other languages, using double qutoes

```lisp
"hello" ; strings are composed with multiples characters

```

All names used in Lisp programs, such `FORMAT` or the name of function, like `full-name` are all represented by objects called *symbols*. You can use almost any character in a name, but not whitespaces. Digits also can appear in name, but it will not be interpreted as a number. Others characters that is used to other propose like double quotes, single quotes, backtick, comma, colon, semicolon, backslash and verical bars.

One important thing regarding how the reader translate the names to symbols object is related with how it treats the case of letters in names and how the reader ensure that the same name is always read as the same symbol.

While reading names, it will convert all unescaped characters in the name to uppercase, thats why when you define a function in REPL you will see the return in upper case:

```lisp
(defun sum (a b)
  (+ a b))

SUM
```

The convension is the use names with hyphenated, like `hello-world`. Also for global variables is used like *NUMBER_OF_RETIRES*, `*` at the start and at the end. Constants start and end with `+`.

# Final examples

```lisp
a ; the symbol a
() ; the empty list
(1 2 3) ; a list of three numebrs
("Hello", "World") ; a list of two strings
(a b c) ; a list with three symbols
(x 1 "foo") ; a list of a symbol, a number and a string
(+ (* 2 3) 4) ; a list of a symbol, a list, and a number
```

And finally one more complete case, contains: four-item list with two symbols, an empty list, another list containing two symbols (`format` and `t`) and finnaly a string.

```lisp
(defun greeter ()
  (format t "Good Morning"))
```


Thats all for now, in the next post we will talk about s-expressions as lisp forms. See you soon.
