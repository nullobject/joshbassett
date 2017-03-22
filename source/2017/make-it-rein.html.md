---
title: Make It Rein
date: 2017-03-22
---

Who wants crazy-ass values in their database? You? I doubt it, you're better
than that. You run a tight ship.

If you hail from the land of Ruby on Rails web apps then you've probably
written a few migrations in your time. Heck, maybe you've even added a `null:
false` constraint to a column or two. You don't want `NULL` values getting all
up in your table and ruining everything, right?

But why did you add that *constraint* at the database-level, rather than just
use a validation in your ActiveRecord model? After all, isn't the database just
a big dumb container for your models?

No. The database is actually your friend, you should leverage its power.

## Database Integrity

[Data integrity](http://en.wikipedia.org/wiki/Data_integrity) is a good thing.
Constraining the values allowed by your application at the database-level,
rather than at the application-level, is a more robust way of ensuring your
data stays sane.

If you consider your database to be the "single source of truth", then you
can't rely on your application to enforce the validity of your data. There are
myriad possibilities for your application can drop the ball on your data
integrity: bugs in your application code, bugs in third-party libraries,
concurrency bugs, custom SQL in your app code, migrations, etc.

Unfortunately, ActiveRecord doesn't encourage (or even allow) you to use
database integrity without resorting to hand-crafted SQL.
[Rein](https://github.com/nullobject/rein) (pronounced "rain") adds a handful
of methods to your ActiveRecord migrations so that you can easily tame the data
in your database.

## Example

Let's have a look at constraining database values for this simple library
application.

Here we have a table of authors:

```ruby
create_table :authors do |t|
  t.string :name, null: false
  t.timestamps, null: false
end

# An author must have a name.
add_presence_constraint :authors, :name
```

We also have a table of books:

```ruby
create_table :books do |t|
  t.belongs_to :author, null: false
  t.string :title, null: false
  t.string :state, null: false
  t.integer :published_year, null: false
  t.integer :published_month, null: false
  t.timestamps, null: false
end

# A book should always belong to an author. The database should prevent us from
# deleteing an author who has books.
add_foreign_key_constraint :books, :authors, on_delete: :restrict

# A book must have a non-empty title.
add_presence_constraint :books, :title

# State is always either "available" or "on_loan".
add_inclusion_constraint :books, :state, in: %w(available on_loan)

# Our library doesn't deal in classics.
add_numericality_constraint :books, :published_year,
  greater_than_or_equal_to: 1980

# Month is always between 1 and 12.
add_numericality_constraint :books, :published_month,
  greater_than_or_equal_to: 1,
  less_than_or_equal_to: 12
```

## Check It Out!

If you're interested in this kind of thing then take a look at the [Rein
project on GitHub](https://github.com/nullobject/rein).
