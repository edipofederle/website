---
title: Compile SBCL (Common Lisp) with Threads support on Mac OSX
date: 2018-11-30T20:39:33
tags: lisp, common lisp, macosx
---

Hey,

Recently I start to read the Practical Common Lisp book, so the first this that I did, after reading the introduction
was trying to install the SBLC in order to run the example and play with the code.

On OSX, I was thinking it should be trivial as:

```
brew install sblc
```

well, it works well, the only bad thing about this is that the pre-compiled version of SBLC for OSX doesn't come with
threads support enabled, this is because it is an experimental feature in SBCL so in order to make it work on OSX you
need to compile using some flags:

```
-- fancy
-- with-sb-thread
```

Here the full commands to do it:

```
curl -O https://sourceforge.net/projects/sbcl/files/sbcl/sbcl-<VERSION>-source.tar.bz2
sudo sh make.sh --fancy --with-sb-thread
sudo sh install.sh
```

It could take some time to finish. To check access the REPL with `scbl`

```lisp

(defun test-sbcl-thread ()
           (let ((top-level *query-io*))
             (sb-thread:make-thread
              (lambda ()
                (format top-level "Hello from ~a~%"
                        (sb-thread:thread-name sb-thread:*current-thread*))))))

(test-sbcl-thread)
```

That's all, I hope to post some things related to "Practical Common Lisp" book as soon as possible.


Take care.
