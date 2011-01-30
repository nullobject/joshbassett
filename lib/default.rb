require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/integer/inflections'
require 'nanoc-code-classifier'

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo

Date::DATE_FORMATS[:long_ordinal] = lambda {|date| date.strftime("#{date.day.ordinalize} %B %Y") }
