---
title: Functions Compositions
date: 2018-12-13
tags: ruby,clojure, functional programming
---


Ruby as a lot of things from Functional Programming (FP), we all use stuffs such `lambdas`, `procs`, and so on. Recently I was thinking about one aspect of FP: functions compositions. If you look at mathematics definition:


> In mathematics, function composition is the pointwise application of one function to the result of another to produce a third function. For instance, the functions f : X → Y and g : Y → Z can be composed to yield a function which maps x in X to g(f(x)) in Z. (Wikipedia)

And in programming is basically the same. In Clojure, for example, we have a function called `comp`. Let's open the REPL and play with it.


```clojure

user=> (doc comp)
-------------------------
clojure.core/comp
([] [f] [f g] [f g & fs])
  Takes a set of functions and returns a fn that is the composition
  of those fns.  The returned fn takes a variable number of args,
  applies the rightmost of fns to the args, the next
  fn (right-to-left) to the result, etc.
nil

user=> (defn add_one [x] (inc x))
#'user/add_one
user=> (defn multi_3 [x] (* 3 x))
#'user/multi_3

user=> ((comp add_one multi_3) 10)
31
user=> ((comp add_one multi_3) 10)
31
user=>
```

So, we can pass any set of functions to `comp` and a return we will get a function that is the composition of all these functions.

But what about Ruby? Well, ruby doesn't contain a built-in `comp` function, but we can write one.


Ruby allow us to pass a function as an argument and return function as well, using a fancy word, higher-order functions. If a language has this capacity, we say that it has first-class function support. In order
to implement a `comp` function in Ruby is exactly what we need.

```ruby

add_one = lambda { |number| number + 1 }
multi_three = lambda { |number|  number * 3 }

def comp(f1, f2)
  lambda { |x| f1.call(f2.call(x)) }
end

comp(add_one, multi_three).call(10) # 31
comp(add_one, multi_three).call(11) # 34
```

If we need to receive 4 functions, we will need to do something like:

```ruby
def comp(f1, f2, f3, f4)
  lambda { |x| f1.call(f2.call(f3.call(f4.call(x)))) }
end
```

This looks like a good case for use a `reduce` function. Let's try to change it to be possible to use any number of functions. This is a case to use the `splat` operator (*), so let's rewrite the function `comp` using it:


```ruby
def comp(*fns)
 fns.reduce { |func, func2| lambda { |n| func.call(func2.call(n))  }}
end
```

If you look at Clojure `comp` [function implementation](https://github.com/clojure/clojure/blob/clojure-1.9.0/src/clj/clojure/core.clj#L2549), you will see that it also use some reduce stuff to do the job.


So, now we can use the new version of `comp` function and pass any number of functions to it.


## References

- [https://www.joinhandshake.com/engineering/2016/01/22/functional-aspects-of-ruby.html](https://www.joinhandshake.com/engineering/2016/01/22/functional-aspects-of-ruby.html)
- [https://github.com/clojure/clojure/blob/clojure-1.9.0/src/clj/clojure/core.clj#L2549](https://github.com/clojure/clojure/blob/clojure-1.9.0/src/clj/clojure/core.clj#L2549)
