---
title: Lettering.js
created_at: 2011-01-31
---

Have you ever dreamed of having down-to-the-letter control of type in CSS?

[Lettering.js](http://letteringjs.com/) is a sweet [jQuery](http://jquery.com/) plugin which allows you tweak the typography of your site. It allows you to target specific letters, words, or lines within a text element by automatically wrapping them in spans. You can then get creative in CSS and use selectors to drill down to the precise span and tweak to your heart's content. Here's some examples of what you can do with it:

![Custom kerning](images/cowpoke.png)
![Per-letter tweaking](images/trent_walton.png)

I'm going to show you the ropes, we'll be using this HTML snippet throughout the examples:

    [@language="html"]
    [@caption="original.html"]
    <article>
      <h1>Lipsum</h1>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      <p>Proin elementum erat id mi aliquam ac fermentum sem sollicitudin.</p>
    </article>

## Character lettering

Sometimes you need to-the-letter control over a piece of text. Maybe you want to adjust the kerning of a heading, or colour each letter differently.

To apply character lettering, you call `lettering()` on a selector.

    [@language="javascript"]
    [@caption="character_lettering.js"]

    $(document).ready(function() {
      $("article > h1").lettering();
    });

The contents of the `h1` element will be split into characters:

    [@language="html"]
    [@caption="character_lettering.html"]
    <article>
      <h1>
        <span class="char1">L</span>
        <span class="char2">i</span>
        ...
        <span class="char6">m</span>
      </h1>
      ...
    </article>

## Word lettering

Now let's say you want apply word lettering to every paragraph. This time you specify the `words` parameter.

    [@language="javascript"]
    [@caption="word_lettering.js"]

    $(document).ready(function() {
      $("article > p").lettering("words");
    });

The contents of each `p` element will be split into words:

    [@language="html"]
    [@caption="word_lettering.html"]
    <article>
      <h1>Lipsum</h1>
      <p>
        <span class="word1">Lorem</span>
        <span class="word2">ipsum</span>
        ...
        <span class="word3">elit.</span>
      </p>
      <p>
        <span class="word1">Proin</span>
        <span class="word2">elementum</span>
        ...
        <span class="word3">sollicitudin.</span>
      </p>
    </article>

## XY crazy shit

You can use jQuery chaining to apply lettering multiple times. For example, let's say we want to apply word lettering to every paragraph and then apply character lettering to the first word in each paragraph:

    [@language="javascript"]
    [@caption="word_and_character_lettering.js"]

    $(document).ready(function() {
      $("article > p:first").lettering("words").children("span").first().lettering();
    });
