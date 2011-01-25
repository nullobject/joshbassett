---
title: Blogging with nanoc
kind: article
created_at: 2011-01-25
---

One of my new year's resolutions was to write a blog. The very page you are reading is a testament to the fact that I was not going to let it slide for another year.

As a programmer, I had to strongly resist the urge to write my own blogging engine (a trap which I had fallen into in the past). Instead I decided to use [nanoc](http://nanoc.stoneship.org/) to generate my blog as a static web site. That way there would be no temptation to procrastinate by reinventing a blogging engine, instead of writing actual blog articles. This was the theory anyway...

## Close but no cigar

My criteria for choosing a templating system was:

1. static site generation
2. ability to write articles in markdown
3. syntax highlighting of code
4. some shit

Nanoc offered the most flexibility at the cost of some added complexiting in the initial configuration. It's plugin system allowed me to choose only the components that I needed. It didn't however solve the problem of syntax highlighting the code blocks embedded in my markdown. If I was willing to write my articles in HTML it would work out of the box, but this was not a sacrifice I wanted to make. This called for a custom nanoc filter.

## Some customisation

The [nanoc-code-classifier](http://github.com/nullobject/nanoc-code-classifier) filter I created allows you to specify the language of your code blocks using special tags. The filter then parses those language tags and massages the HTML into a format which will work with syntax highlighers (such as [coderay](http://coderay.rubychan.de/)).

The `@language` tag sets the language of the code block. You can use the `@caption` tag to optionally specify a caption for the code block.

The following example demonstrates how to use tags to identify a Ruby code block:

    [@language="markdown"]
    [@caption="hello_world.md"]

    Here is a ruby code block:

        [@language="ruby"]
        [@caption="hello_world.rb"]

        puts "hello world"

## Configuring nanoc

Add the following rule to your Rules file:

    [@language="ruby"]
    [@caption="Rules"]

    compile '/*/' do
      filter :bluecloth
      filter :code_classifier, :pre => {:class => "coderay"}, :caption => {:position => :top}
      filter :colorize_syntax
      layout 'article'
    end

The rule defines a filter pipeline which:

1. uses bluecloth to convert the markdown into HTML
2. applies code classifer filter to inject the required classes into the HTML
3. uses coderay to perform syntax highlighting
