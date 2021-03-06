---
title: Reactive UIs with React & Bacon
date: 2014-04-19
---

**I've** been experimenting with [React.js](http://facebook.github.io/react/)
after recently watching a great presentation by [Pete
Hunt](https://github.com/petehunt) at [JSConf AU 2014](http://au.jsconf.com).
Like many great tools, React focuses on one problem: the views in your web
application. The rest of the technology stack is left up to you. If you haven't
had a chance to play with React, I highly recommend spending a couple of hours
reading up on it.

If, like me, you're used to building web applications around the
[MVC](http://en.wikipedia.org/wiki/Model-view-controller) design pattern, then
your next move is likely to reach for something like
[Backbone.js](http://backbonejs.org).

## React & Backbone

As it turns out, Backbone is quite a nice fit with React. You can simply switch
out your Backbone views with React components. There's even a nice little
[mixin](https://gist.github.com/ssorallen/7883081).

Let's say that we have two React components: a `TextField` and `Label`.
They're both bound to the same Backbone model, so when the text in the text
field changes the label updates its text automatically. To make things more
interesting the label shows the text in reverse.

Here's the example (also available on [CodePen](http://codepen.io/nullobject/pen/kcjxD?editors=001)):

```coffeescript
# Reverses a given string.
reverse = (s) -> s.split('').reverse().join('')

# A text field component.
TextField = React.createClass
  propTypes:
    model: React.PropTypes.instanceOf(Backbone.Model).isRequired

  handleChange: (text) ->
    @props.model.set('text', text)
    @forceUpdate()

  render: ->
    valueLink = {value: @props.model.get('text'), requestChange: @handleChange}
    React.DOM.input(type: 'text', placeholder: 'Enter some text', valueLink: valueLink)

# A label component.
Label = React.createClass
  propTypes:
    model: React.PropTypes.instanceOf(Backbone.Model).isRequired

  componentDidMount: ->
    boundForceUpdate = @forceUpdate.bind(this, null)
    @props.model?.on('all', boundForceUpdate)

  render: ->
    text = @props.model.get('text')
    React.DOM.p(null, reverse(text))

# The model represents the state of the text field component.
model = new Backbone.Model(text: 'hello world')

React.renderComponent(
  React.DOM.div(
    null,
    TextField({model}),
    Label({model})
  ),
  document.body
)
```

In the `componentDidMount` function of the `Label` component we create a
binding and force an update to the component whenever the model changes. We
also create a binding in the `render` function of the `TextField` component and
listen for changes to the text input. Whenever the text changes, we propagate
those changes to the model and vice versa. Seems simple, right? Unfortunately
this didn't quite gel for me.

One of my problems with this approach was that the React components *already*
had a one-way data binding to their state object. This means that the component
is automatically updated whenever the state changes via a call to its
`setState` function.  Circumventing this default behaviour with another state
object (i.e.  a Backbone model) and custom data bindings seemed to be at odds
with this simplicity.  Perhaps this wasn't the 'React way'?

I started thinking: do I even need a model? What if there was a way I could
represent the state of a component over time, transform it in some way, and
pipe it into another component? Hang on a second, this sounds a lot like
reactive programming to me!

## Reactive Streams

In JavaScript we typically deal with asynchronous interactions by observing
some object for an event and firing a callback whenever that event occurs.
However, when there is a more complex set of interactions (e.g. wait for event
A, then wait for event B, ...) things start to become more complex. You can
quickly end up in what is affectionately known as [callback
hell](http://callbackhell.com).

[Reactive programming](http://en.wikipedia.org/wiki/Reactive_programming) is a
programming paradigm which attempts to address this inherent complexity in
asynchronous systems. It does so by modelling the *flow* of data between the
parts of a system using data structures called *streams*.

Rather than dealing with discrete events, you can think of streams as a
continuous flow of data. Streams are first-class values and can be manipulated
using all of your usual functional programming tools (e.g. `map`, `reduce`,
`filter`, etc). They are also like little garden hoses which can be split,
joined, and interleaved.

## React & Bacon

Armed with some reactive programming smarts, I decided to model the connection
between my two React components using a stream. The state of the `TextField`
component over time could be modelled using a stream which I could then map a
reverse function over before passing it to the `Label` component.

Two popular reactive programming libraries for JavaScript are
[RxJS](https://github.com/Reactive-Extensions/RxJS) and
[Bacon.js](https://github.com/baconjs/bacon.js). I chose to use Bacon, but
these examples should be much the same if you're using RxJS.

Here's the same example using reactive streams (also available on [CodePen](http://codepen.io/nullobject/pen/uIlAC?editors=001)):

```coffeescript
# Reverses a given string.
reverse = (s) -> s.split('').reverse().join('')

# Reverses the text property of a given object.
reverseText = (object) ->
  object.text = reverse(object.text)
  object

# A text field component binds the text in an <input> element to an output stream.
TextField = React.createClass
  getInitialState: ->
    text: ''

  handleChange: (text) ->
    @setState({text}, -> @props.stream.push(@state))

  render: ->
    valueLink = {value: @state.text, requestChange: @handleChange}
    React.DOM.input(type: 'text', placeholder: 'Enter some text', valueLink: valueLink)

# A label component binds an input stream to the text in a <p> element.
Label = React.createClass
  getInitialState: ->
    text: ''

  componentWillMount: ->
    @props.stream.onValue(@setState.bind(this))

  render: ->
    React.DOM.p(null, @state.text)

# The text stream object represents the state of the text field component over time.
textStream = new Bacon.Bus

# The label stream is the text stream with the reverseText function mapped over it.
labelStream = textStream.map(reverseText)

React.renderComponent(
  React.DOM.div(
    null,
    TextField(stream: textStream),
    Label(stream: labelStream)
  ),
  document.body
)
```

As you can see, data flows from the `TextComponent` through the `reverseText`
function and into the `Label` component. It's much easier to follow how data is
transferred between the components. Perhaps this example is a little too
contrived, but the real power of reactive streams becomes apparent when you
want to do something more complex.  Rather than reversing the values in the
`textStream`, we could map the latest value of the `textStream` through another
stream. For example, to look up the definition of the text using a dictionary
API.

## Recommended Reading

There's some interesting things afoot in the reactive programming world at the
moment. The [Reactive Streams](http://www.reactive-streams.org) working group
recently released a draft proposal for a reactive stream specification. I also
recommend reading the [Reactive Manifesto](http://www.reactivemanifesto.org)
which was published late last year.

[Discuss this article on Hacker News.](https://news.ycombinator.com/item?id=7612952)
