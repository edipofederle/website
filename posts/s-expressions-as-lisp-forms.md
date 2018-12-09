---
title: Common Lisp Forms s-expressions
date: 2018-12-09T20:39:33
tags: common lisp, lisp
---

In order to perform any computation, we need to be enabled to evaluate the code. Once the reader translates the text into s-expressions, they are ready to be evaluated as Lisp code. Some s-expressions are not evaluated as Lisp code. The reader contains a second level of syntax that determines which s-expressions will be evaluated as Lisp forms.

The syntactic rules are: any atoms, any non-list or the empty list is a valid Lisp form, also any list that has a symbol its first element. You can think about the evaluator as a function that takes as an argument a syntactically and well-formated Lisp form and as a result, return a value.

The simplest forms in Lisp is the atoms, and we can split into two categories:

- symbols
- anything else

A symbol is evaluated as a form, and it considers the name of the variable and evaluates to the current value of the variable. Some other as called constants, like `PI`. All others atoms, like numbers and string, are evaluated to himself. So when this is passed to our imaginary evaluator function, they are simply returned. You can check it into the REPL:

```lisp
CL-USER> 10
10
CL-USER> "Hi, I am a String"
"Hi, I am a String"
CL-USER>
```

The `keywords` symbols, which start with `:` are self-evaluating symbols. So when the reader read it, it automatically defines a constant variable with the name and with the symbol as the value. But the things is more nice and interesting when evaluation lists. All valid lists forms start with a symbol, but they are evaluated differently. The evaluator needs to determine what kind of form the given list is, to do it, is necessary to know if the symbol is a function name, a macro or a special operator.

If the symbol is not defined yet, the evaluator will assume that it is a function. In Common Lisp, a symbol can name both, an operator, function, macro or special operator, and variable. In Schema, for example, it cannot happen. This difference is sometimes described as Common Lisp being a Lisps and Schema a Lisp-1. In Lisps-2, has two namespaces, one for an operator and one for variables, but in Lisp-1 uses a single namespace.

This is a basic introduction to in the next posts we will see this three different forms.

See you soon.
