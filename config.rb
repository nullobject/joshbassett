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

# Activate S3 sync extension.
require 'fog'
Fog.credentials = {path_style: true}
activate :sync do |sync|
  sync.fog_provider  = 'AWS'
  sync.fog_directory = 'joshbassett.info'
  sync.fog_region    = 'us-east-1'

  sync.aws_access_key_id     = 'AKIAJI634S7N2KDON2MA'
  sync.aws_secret_access_key = 'acMzJzNX1hlY8O3LvVBShoVlx1IBPqeFwPAyihxQ'

  sync.existing_remote_files = 'keep' # What to do with your existing remote files? ( keep or delete )
  # sync.gzip_compression = false # Automatically replace files with their equivalent gzip compressed version
  # sync.after_build = false # Disable sync to run after Middleman build ( defaults to true )
end

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
