require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/integer/inflections'
require 'nanoc-code-classifier'

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo

Date::DATE_FORMATS[:long_ordinal] = lambda {|date| date.strftime("#{date.day.ordinalize} %B %Y") }

def articles_by_year_month
  sorted_articles.group_by do |article|
    created_at = article[:created_at]
    [created_at.year, created_at.month]
  end.sort_by do |(year, month), _|
    [year, month]
  end.reverse
end
