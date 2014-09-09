Date::DATE_FORMATS[:long_ordinal] = lambda {|date| date.strftime("#{date.day.ordinalize} %B %Y") }

Time.zone = 'Melbourne'

activate :blog do |blog|
  blog.permalink = '{year}/{title}.html'
  blog.sources   = "{year}/{title}.html"
  blog.layout    = 'article'
end

page "/feed.xml", layout: false

# Output files as index files in a directory.
activate :directory_indexes

# Reload the browser automatically whenever files change
activate :livereload

# Enable syntax highlighting.
activate :syntax

# Set the markdown engine.
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# Set asset directories.
set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

# Build configuration.
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
