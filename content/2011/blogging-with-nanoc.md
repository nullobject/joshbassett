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
2. ability to write articles in Markdown
3. code block syntax highlighting

There are a number of static site generators out there, but nanoc offered the most flexibility at the cost of some added complexity in the initial configuration. It's plugin system allowed me to choose only the components that I needed, it didn't however solve the problem of syntax highlighting the code blocks embedded in my Markdown. This called for a custom nanoc filter.


## Some customisation

I created a nanoc filter called [nanoc-code-classifier](http://github.com/nullobject/nanoc-code-classifier) which allows you to specify the language of your code blocks using special tags. The filter then parses those language tags and injects CSS classes into the code blocks, which will then work with syntax highlighers (such as [coderay](http://coderay.rubychan.de/)).

The `@language` tag sets the language of the code block. You can use the `@caption` tag to optionally specify a caption for the code block.

The following example demonstrates how to use tags to create a Ruby code block in Markdown:

    [@language="markdown"]
    [@caption="hello_world.md"]

    This is how you print "hello world" to the console in Ruby:

        [@language="ruby"]
        [@caption="hello_world.rb"]

        puts "hello world"


## Configuring nanoc

To get this bad boy pimping your blog you'll need to define a rule which:

1. applies bluecloth to convert the Markdown into HTML
2. applies the code classifer to inject the CSS classes in the code block
3. applies coderay to perform syntax highlighting

For example:

    [@language="ruby"]
    [@caption="Rules"]

    compile '/*/' do
      filter :bluecloth
      filter :code_classifier, :pre => {:class => "coderay"}, :caption => {:position => :top}
      filter :colorize_syntax
      layout 'default'
    end
