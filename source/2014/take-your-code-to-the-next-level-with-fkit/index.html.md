---
title: "Take Your Code to the Next Level with FKit"
date: 2014-10-13
---

<img src="images/fkit.png" align="right" width="128px">

Recently I've been busy working on [FKit](https://github.com/nullobject/fkit):
a functional programming toolkit for JavaScript. It provides many functions for
solving common problems with functions, objects, arrays, and strings.

I wrote FKit because I believe that JavaScript is lacking the kind of standard
library that many other languages benefit from. A good example is the `prelude`
library in Haskell: it provides developers with an amazing toolbox to write
their Haskell applications with. Why should JavaScript developers have to
bother solving these common problems over and over again?

Other libraries have attempted to address this issue (Underscore, Lo-dash,
etc), but in my opinion they're rudimentary. The implication is that you often
have to “reinvent the wheel” while writing JavaScript day-to-day.

FKit is my attempt at a *standard library* for JavaScript. It aims to provide
reusable building blocks while maintaining a laser focus on everyday utility.
This article explains some of the core features of FKit and gives some
background to many of the functional programming concepts it uses.

## Curried Functions

<img src="images/curry.png" align="left">

Most functions in FKit are already *curried by default*, so it's worth spending
some time explaining curried functions.

A *curried function* is a function that instead of taking multiple arguments
takes exactly one argument. It returns another function that takes exactly one
argument, and so on. When all the arguments are specified, the result is
returned.

To illustrate this concept let's define a curried function `add` that simply
adds two numbers together. It takes a value `a` and returns another function
that takes a value `b`. When `add` is applied to the values `a` and `b` then
the result `a + b` is returned:

``` js
function add(a) {
  return function(b) {
    return a + b;
  };
}
add(1)(2); // 3
```

With FKit you can easily curry a function of any
[arity](http://en.wikipedia.org/wiki/Arity) using the `F.curry` function:

``` js
var add3 = F.curry(function(a, b, c) { return a + b + c; });
add3(1)(2)(3); // 6
```

## Partially Applied Functions

<img src="images/fx.png" align="right">

What happens when we don't specify all the arguments to a curried function?
Let's find out.

First, let's define a curried function `mul` that multiplies two numbers
together:

``` js
function mul(a) {
  return function(b) {
    return a * b;
  };
}
mul(1)(2); // 2
```

When we apply `mul` to one value only, we get what is known as a *partially
applied function* instead the result `a * b`:

``` js
mul(2); // function
```

Here the `mul` function has been *partially applied* to the value `2`. This
results in another function which simply multiplies a given number by `2`; in
other words, it *doubles* a given number.

This is actually quite useful. For example, we can assign the partially applied
`mul` function to the variable `double` and apply it to some other values:

``` js
var double = mul(2);
double(1); // 2
double(2); // 4
double(3); // 6
```

Many of the functions in FKit can be partially applied to expressively and
elegantly solve problems. Let's take a look at a few examples using FKit.

Here we multiply each number in a list by two:

``` js
[1, 2, 3].map(F.mul(2)); // [2, 4, 6]
```

By using the `reduce` function with `F.add` (a binary function), we can sum all
the numbers in a list:

``` js
[1, 2, 3].reduce(F.add); // 6
```

To filter the all the numbers in a list which are greater than one, we can use
the `F.gt` predicate:

``` js
[1, 2, 3].filter(F.gt(1)); // [2, 3]
```

## Function Composition

<img src="images/notes.png" align="left">

Function composition is a powerful way to specify a series of functions, where
each function takes the result of another function as an argument. In other
words, `compose(f, g)` is equivalent to saying `f(g(a))`.

Now let's define a function `compose` that composes two functions together:

``` js
function compose(f, g) {
  return function(a) {
    return f(g(a));
  };
}
```

Using our `add` and `mul` functions from earlier, we can compose a function
`doubleAndAddOne` that doubles and adds one to a given number:

``` js
var doubleAndAddOne = compose(add(1), mul(2));
doubleAndAddOne(1) // 3
doubleAndAddOne(2) // 5
doubleAndAddOne(3) // 7
```

FKit allows you to easily compose any number of functions together using the
`F.compose` function:

``` js
var myFunction = F.compose(f, g, h);
```

## Lists

Have you ever wondered why you can call `reverse` on an array, but not on a
string?

``` js
[1, 2, 3].reverse(); // [3, 2, 1]

'foo'.reverse();
TypeError: Object foo has no method 'reverse'.
```

This is because arrays and strings are fundamentally different data types in
JavaScript. Other languages don't make this distinction; after all, a string is
really just a *list of characters*. Imagine how useful it would be to use the
same functions on different kinds of lists, whether it be an array of numbers
or a string?

<p align="center"><img src="images/listmonster.png"></p>

FKit provides many list functions and they all work in exactly the same way for
arrays as they do for strings. This seemingly simple abstraction is very
powerful.

To highlight this point, let's look at some basic list functions on both arrays
and strings:

``` js
F.head([1, 2, 3]); // 1
F.head('foo'); // 'f'

F.tail([1, 2, 3]); // [2, 3]
F.tail('foo'); // 'oo'

F.last([1, 2, 3]); // 3
F.last('foo'); // 'o'

F.init([1, 2, 3]); // [1, 2]
F.init('foo'); // 'fo'
```

We can also create new lists by adding elements to lists:

``` js
F.append(3, [1, 2]); // [1, 2, 3]
F.append('o', 'fo'); // 'foo'

F.prepend(1, [2, 3]); // [1, 2, 3]
F.prepend('f', 'oo'); // 'foo'

F.surround(0, 4, [1, 2, 3]); // [0, 1, 2, 3, 4]
F.surround('¡', '!', 'hola'); // '¡hola!'

F.intersperse(4, [1, 2, 3]); // [1, 4, 2, 4, 3]
F.intersperse('-', 'foo'); // 'f-o-o'
```

Joining lists together? No problemmo:

``` js
F.concat([1], [2, 3], [4, 5, 6]); // [1, 2, 3, 4, 5, 6]
F.concat('f', 'oo', 'bar'); // 'foobar'
```

Building new lists? It's a snack:

``` js
F.replicate(1, 3); // [1, 1, 1]
F.replicate('a', 3); // 'aaa'
```

## Combinators

<img src="images/map.png" align="right">

JavaScript provides several *combinators* for working with arrays, for example
`map`, `filter` and `reduce`. Combinators are higher-order functions (functions
that takes other functions as arguments) that iterate over arrays – or more
generally, *any* data structure – in some way.

FKit also provides all of your favourite combinators, plus a few more you may
not have encountered before. They also all work on both strings and arrays!

`F.map` takes a function and applies it to every element in a list, returning a
new list:

``` js
F.map(F.inc, [1, 2, 3]); // [2, 3, 4]
F.map(F.toUpper, 'foo'); // ['F', 'O', 'O']
```

`F.filter` filters the elements in a list using a predicate function:

``` js
F.filter(F.gt(1), [1, 2, 3]); // [2, 3]
F.filter(F.eq('o'), 'foo'); // 'oo'
```

`F.fold` folds a list into a single value using a binary function and a
starting value:

``` js
F.fold(F.add, 0, [1, 2, 3]); // 6
F.fold(F.flip(F.prepend), '', 'foo'); // 'oof'
```

`F.zip` zips the corresponding elements from two lists into a list of pairs:

``` js
F.zip([1, 2, 3], [4, 5, 6]); // [[1, 4], [2, 5], [3, 6]]
F.zip('foo', 'bar'); // [['f', 'b'], ['o', 'a'], ['o', 'r']]
```

`F.concatMap` maps a function that returns a list over every element in a list,
and concatenates the results:

``` js
function p(a) { return [a, 0]; }
F.concatMap(p, [1, 2, 3]); // [1, 0, 2, 0, 3, 0]

function q(a) { return a + '-'; }
F.concatMap(q, 'foo'); // 'f-o-o-'
```

## Immutable Objects

Even though it leads to much simpler application development, JavaScript
doesn't enforce any constraints on the [immutability of
objects](http://en.wikipedia.org/wiki/Immutable_object). Developers tend to
solve problems by mutating the state of their objects, leading to hard-to-find
bugs.

FKit provides several functions to make it easy to work with immutable objects.
To begin the next example, let's define a list of shapes:

``` js
var shapes = [ 
  {type: 'circle', colour: 'red', size: 1},
  {type: 'square', colour: 'green', size: 2}, 
  {type: 'triangle', colour: 'blue', size: 3} 
]; 
```

If we want to get the colour of each shape we can use the `F.get` function:

``` js
shapes.map(F.get('colour'));  // ['red', 'green', 'blue']; 
```

What if we want to change a property of the shapes? We can use the `F.set`
function to do that:

``` js
shapes.map(F.set('size', 100)); 
// [{..., size: 100}, {..., size: 100}, {..., size: 100}]
```

Importantly, in the above example the original shapes remain unchanged. FKit
makes a copy of each of the shapes and sets the `size` property to `100`. FKit
will also respect the prototype of the original object and ensure that the copy
has the *same* prototype as the original.

## Learn Some More

Hopefully by now you've learned something about FKit and some of the functional
programming concepts behind it. What you've seen in this article is only the
tip of the iceberg.

I encourage you to take a look at the [FKit project on
GitHub](https://github.com/nullobject/fkit) and read through the [API
docs](http://nullobject.github.io/fkit/api.html) if you want to learn more.

## Credits

The images in this article are borrowed from the wonderful book [Learn You a
Haskell for Great Good](http://learnyouahaskell.com) by Miran Lipovača.

This work is licensed under a [Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International
License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

[Discuss this article on Hacker News.](https://news.ycombinator.com/item?id=8448194)
