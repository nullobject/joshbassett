require 'active_support/core_ext/date'
Date::DATE_FORMATS[:long_ordinal] = lambda { |date| date.strftime("#{date.day.ordinalize} %B %Y") }

Time.zone = 'Melbourne'

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Add vendor prefixes to CSS.
activate :autoprefixer do |config|
  config.ignore = ['/fonts/*']
end

activate :blog do |blog|
  blog.permalink = '{year}/{title}.html'
  blog.sources   = "{year}/{title}.html"
  blog.layout    = 'article'
end

# Configure Google Analytics.
activate :google_analytics do |ga|
  ga.tracking_id = 'UA-20723605-1'
end

# Output files as index files in a directory.
activate :directory_indexes

# Enable syntax highlighting.
activate :syntax

# Set the markdown engine.
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# Set asset directories.
set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

configure :development do
  activate :livereload
  activate :disqus do |d|
    d.shortname = "joshbassett-development"
  end
end

configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  activate :disqus do |d|
    d.shortname = "joshbassett"
  end
end
