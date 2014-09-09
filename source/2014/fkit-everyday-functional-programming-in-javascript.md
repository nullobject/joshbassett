---
title: "FKit: Everyday Functional Programming in JavaScript"
date: 2014-08-09
published: false
---

# Pure Functions

A *pure function* is a function which always returns the same output, given the same input.

Here’s an example of a pure `add` function:

``` js
function add(a, b) { return a + b; }
add(1, 2);
=> 3
```

We can rewrite the `add` function so that it is *impure*:

``` js
var c = 0; // external state
function add(a, b) { return a + b + c; }
add(1, 2);
=> 3
```

Because `add` now depends on some external state `c` it doesn’t always return the same output, given the same input:

``` js
c = 1;
add(1, 2); // same input
=> 4
```

# Curried Functions

[Currying](http://en.wikipedia.org/wiki/Currying) is a technique for
transforming a function which takes multiple arguments into a sequence of
functions that each take one argument.

We can use the `fkit.curry` function to curry a given function:

```js
function add(a, b) { return a + b; }
var f = fkit.curry(add);
k(1)(2);
=> 3
```

FKit provides curried versions for many of the standard JavaScript functions
and operators. Using the `fkit.add` function (which is the curried version
of the `+` operator) the above code can be rewritten as:

```js
fkit.add(1)(2);
=> 3
```

# Partial Application

If we don't specify all the arguments to a curried function, then instead of a
result we get what is known as a *partially applied function*. This is useful
because the partially applied function can be used in further calculations.

For example, we can partially apply the `fkit.mul` function to the value
`2`. This results in a new function which multiplies a given number by two:

```js
var f = fkit.mul(2);
f(1);
=> 2
f(2);
=> 4
f(3);
=> 6
```

# Function Composition

The `fkit.compose` function can be used to compose two or more functions
together into a new function.

This function adds one to a given number, then multiplies it by two and
subtracts three:

```js
var f = fkit.compose(fkit.sub(3), fkit.mul(2), fkit.add(1));
f(1);
=> 1
f(2);
=> 3
f(3);
=> 5
```

# Combinators

FKit provides curried versions of all your favourite combinators: map, filter, fold, and scan.

## Map

Using `fkit.map` we can map a function over a list. Here we multiply every
number in the list by two:

```js
var f = fkit.map(fkit.mul(2));
f([1, 2, 3]);
=> [2, 3, 4]
```

## Filter

Using `fkit.filter` we can filter a list using a *predicate function*. In this
example we filter all numbers in the list that are greater than one:

```js
var f = fkit.filter(fkit.gt(1));
f([1, 2, 3]);
=> [2, 3]
```

## Fold

Using `fkit.fold` we can fold a list with a binary function and get a single
value. Here we sum all the numbers in the list:

```js
var f = fkit.fold(fkit.add, 0);
f([1, 2, 3]);
=> 6
```

## Scan

Using `fkit.scan` we can scan a list with a binary function and a list of
values. Here we again sum all the numbers in the list and get the intermediate
values:

```js
var f = fkit.scan(fkit.add, 0);
f([1, 2, 3]);
=> [0, 1, 3, 6]
```

# Branching

```js
var f = fkit.branch(fkit.gte(100), function(a) { return 'large'; }),
    g = fkit.branch(fkit.gte(10), function(a) { return 'medium'; }),
    h = function(a) { return 'small'; },
    i = fkit.compose(f, g)(h);

i(1);
=> 'small'
i(12);
=> 'medium'
i(123);
=> 'large'
```
