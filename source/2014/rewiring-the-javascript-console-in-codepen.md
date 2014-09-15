---
title: Rewiring the JavaScript Console in CodePen
date: 2014-09-16
---

JavaScript hackers are familiar with using the functions in the `console`
module to print output from their code. When your code runs in a browser, the
console output is sent to the web inspector's error console. Otherwise, if it's
running in NodeJS then the console output is sent to stdout or stderr in your
terminal.

Wouldn't it be cool if you could rewire the console in CodePen to print
messages to the *result* panel, instead of being hidden away in the web
inspector? Behold the rewired console:

<p data-height="200" data-theme-id="8402" data-slug-hash="rAbio" data-default-tab="result" data-user="nullobject" class='codepen'>See the Pen <a href='http://codepen.io/nullobject/pen/rAbio/'>CodePen JavaScript Console Template</a> by Josh Bassett (<a href='http://codepen.io/nullobject'>@nullobject</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

Now you can use the standard `console.log`, `console.info`, `console.warn`, and
`console.error` functions to print messages to the rewired console. You can
even call `console.clear` to clear all messages.

What if your pen produces so much output that the *result* panel overflows and
you can no longer see the messages as they are printed? The answer is the
`console.follow` function.

If you enable *following* then the console will scroll to the bottom every time
a message is printed. Here's an example:

<p data-height="200" data-theme-id="8402" data-slug-hash="swcfe" data-default-tab="result" data-user="nullobject" class='codepen'>See the Pen <a href='http://codepen.io/nullobject/pen/swcfe/'>FKit: Signals</a> by Josh Bassett (<a href='http://codepen.io/nullobject'>@nullobject</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

If you would like to use console rewiring in your next pen, then simply [fork
this pen](http://codepen.io/nullobject/pen/rAbio) to get started.

Enjoy!

[Discuss this article on Hacker News.](https://news.ycombinator.com/item?id=8322117)
