###
# Page options, layouts, aliases and proxies
# For custom domains on github pages

# Per-page layout changes:
#
# With no layout
page "CNAME", layout: false
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '.htaccess.apache', layout: false
page 'redirects/.htaccess.apache', layout: false
page 'feed.xml', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# Requires
require 'builder'

# Blog activation
activate :blog do |blog|
  blog.name = 'blog'
  blog.prefix = 'blog'
  blog.permalink = '{year}/{title}'
  blog.layout = 'blog-layout'
  blog.new_article_template = 'source/blog/article-templates/default.erb'
  blog.tag_template = 'tag.html'
  blog.taglink = 'blog/category/{tag}/index.html'
end
#Copy above to make new blog

# Define where site assets will live
set :css_dir, '_assets/css'
set :js_dir, '_assets/js'
set :images_dir, 'blog/images'
#set :content_dir, '../../content' | This is the content directory relative to the images_dir
set :partials_dir, 'partials'

# Use relative URLs & pretty URLs
activate :relative_assets
activate :directory_indexes   #render posts as index.html in post-titled folder

#automagically build in cross-browser css language
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end 

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Any files you want to ignore:
  #ignore '/admin/*'

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash
end

# This will push to the gh-pages branch of the repo, which will
# host it on github pages (If this is a github repository)
#activate :deploy do |deploy|
#  deploy.method = :git
#  deploy.build_before = true
#end