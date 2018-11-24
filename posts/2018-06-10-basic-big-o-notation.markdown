---
title: The minimum you need knows about Big O Notation
tags: algorithms, complexity, big-o
---
Big O notation is one of the topics that most of us scare at first look. Well, this is a complex topic, if we look deeper, and from the mathematical side. This is important too, but for us,  software developers/engineers, know the basics of this subject can be very useful, at least when I need to work with a huge quantity of data.

This blog post aims to present the basics of this topic, in order to allow you to identify and correct choose the algorithms and data structures to resolve particular problems.


We are going to use Ruby programming language to show the code examples, but the code is simple and you can translate into your favorite language if wish.


## Context

The Big O notation is a fancy name used in Computer Science (CS) to describe the performance and/or complexity of an algorithm. Is important note that Big O always considers the worst-case scenario. It can be used to describe the execution time spent to execute a particular algorithm or the space used(memory or disk).

We cover the most commons groups of complexity:

- Big O(1)     - Constant
- Big O(n)     - Linear
- Big O(nˆ2)   - Quadratic
- Big O(2ˆn)   - Exponential
- Big O(log N) - Logarithmic

## O(1) - Constant

As the name says, that category of complexity will execute always at the same time or space, not matters the size of the input.

Examples:

### Check if a number if odd or even

```ruby
def off_or_even?(number)
   number % 2 == 0 ? "Even" : "Odd"
end
```

### Look up into a HashTable

HashTables (HashMaps in Ruby) are great data structure and we can solve a bunch of problems using it. Look-up on a HashMap is also constant time.

```ruby
ratings_per_listing = {  "12342" => 45, "65313" => 60, "45412" => 11, "12048" => 43 }

def ratings_per_month(ratings_per_listing, listing_id)
   ratings_per_listing[listing_id]
end

ratings_per_month(ratings_per_listing, "12342") # 45
ratings_per_month(ratings_per_listing, "65313") # 60
```

Again, no matters if the `ratings_per_listing` contains 4 elements or 5 million we always need just 1 instruction to get the result.

We could, use another data-structure to store the data, lets say the most known data-structure: **Array**. We could store this data into a **Array** like this:

```ruby
ratings_per_listing = [["12342", 45], ["65313", 60], ["45412", 11],
                       ["12048", 43]]
```

Then we can write the following code to look-up on this **Array**

```ruby
def ratings_per_month(ratings_per_listing, listing_id)
  ratings_per_listing.each do |rating|
    if rating[0] == listing_id
      return rating[1]
    end
  end
end
```

In the worst-case scenario, using the above algorithm, we need to execute the `if` statement the same times of the size of the input. Definitely not an ideal solution.


**Note 1: Don't fall into *one line* trap**

Many people to believe that a single line of code means O(1). Please, don't fool yourself, take this code has an example:

```ruby
arr.map(&:even?)
```

or

```ruby
arr.sort
```

This is *just* one line of code, but Ruby internals need to do a lot of work to handle it for you. So, we need to be known the implementation. By the way, [did you know which algorithm the `Array.sort`use ?](https://www.igvita.com/2009/03/26/ruby-algorithms-sorting-trie-heaps/)

So, long story short, know data-structures and which your *magic* one-liner code does behind the scenes.

##  Big O(n) - Linear

This kind of algorithm applies the need of *visiting* ever each element of the input (in the worst-case scenario). So, this means that as the input grows, the time to complete execution is proportional to the input size.

Examples:

The most classic example here is to find a number on an unsorted **Array**:

```ruby
def find_max_value(arr)
  max = 0
  counter = 0

  arr.each do |value|
    if value > max
      max = value
    end
  end

  max
end
```

In the worst-case scenario, we need `arr.size` execution to find the maximum value of the `arr` **Array**.

If we can count the instruction (complexity), we have this:

```ruby
def find_max_value(arr)
  max = 0                       # <= 1
  counter = 0                   # <= 1

  arr.each do |value|           # <= arr.size (n)
    counter = counter + 1       # <= 1
    if value > max              # <= 1
      max = value               # <= 1
    end
  end

  puts "size: #{arr.size}, executions: #{counter}"
  max
end
```

So we have this: `2 + 3 * n`,  follow the Asymptotic Analysis, we need to keep only the more significative terms, so we can keep only `n`, which give us O(n) complexity.

```ruby
find_max_value([10,12,34,12])
size: 4, executions: 4
=> 34

find_max_value([10,12,34,12,15,50,391,59,19,50])
size: 10, executions: 10
=> 391
```

As you can see, we include some extra output to let us see how many times the loop execute. If you plot a graph, we can see exactly the linear growth:

<img src="https://s3-us-west-2.amazonaws.com/personal-edipo/linear.png"></img>


### O(nˆ2) - Qudratic

In this kind of complexity, the growth rate will be `n^2`. This means that if your input dataset is size 2, it will execute 4 operations if the dataset is 4, 8 executions and soon on.

Example:

```ruby
def bubble_sort(arr)
  for i in 0..arr.size
    for j in (i + 1..arr.size - 1)
      if(arr[i] > arr[j])
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  end

  arr
end
```

The graph shows the growth of the `bubble_sort` function. As we can see, the number of executions grows very quickly.

<img src="https://s3-us-west-2.amazonaws.com/personal-edipo/quadratic.png"></img>

Usually, when a function contains a single loop it is translated to constant time. and when the function contains two nested loops, it is translated to quadratic time.

## Big O(2ˆn) - Exponential

This kind of algorithm means that every time the input grows the executions performed double. One example of this kind of algorithm finds all subsets of a set (array here). Check out this code:

```ruby
def subset(arr)
  total_number_of_subsets = 2 ** arr.size
  result = []

  for i in 0..total_number_of_subsets do
    subresult = []

    for j in (0..arr.size - 1)
      if i&(1 << j) != 0
        subresult << arr[j]
      end
    end
    result << subresult
  end

  result
end
```

If we plot a graph for this algorithm we can clearly notice how very quick this algorithm grows:

<img src="https://s3-us-west-2.amazonaws.com/personal-edipo/2%CB%86n.png"></img>

You should try to avoid this kind of algorithm, if possible. As you can see at the graph, it does not scale very well.


## O(log N) - Logarithmic

The most common example of a logarithmic algorithm is the classic binary search. Once explain this type of category is a little difficult, let's use that example to explore this kind of complexity.

The binary search is a very efficient algorithm to find an element in a sorted array. The search is executed in steps, in each step we reduce the search space by half. After `cut` space if two, we selected the midpoint and test it against the search value. If the midpoint is `<` then the search value, we only select the upper half of the input for the next step. We repeat this until found (or not found) the searched element.

So, if we had an array of `n` elements, the linear solution will be O(n), and in the worst-case scenario, we will need `n` steps to find the target value. In other hands, a binary search has the complexity of O(log N). So let's compare both solutions to search an element in an array of 1000 elements:

**linear:** - an average of 500 steps and 1000  in the worst-case scenario (we need consider the last one)
**logarithmic:** -     `log_2^1000` = about 10 steps.

So, a HUGE difference.

So, for this kind of algorithm, if we double the size of the input, we will have a little effect on algorithm growth. This kind of algorithm is very efficient when we need to deal with a large amount of data.


```ruby
def binary_search(an_array, item)
    first = 0
    last = an_array.length - 1

    while first <= last
        i = (first + last) / 2

        if an_array[i] == item
            return "#{item} found at position #{i}"
        elsif an_array[i] > item
            last = i - 1
        elsif an_array[i] < item
            first = i + 1
        else
            return "#{item} not found in this array"
        end
    end
end
```
# Conclusion

In this article, we cover the basics of Big O notation, but it would be enough to avoid some commons mistakes when writing programs.  You can find more details about this subject in the following resources:

- [Big O notation - MIT](web.mit.edu/16.070/www/lecture/big_o.pdf)
- [Know Thy Complexities!](http://bigocheatsheet.com/)
