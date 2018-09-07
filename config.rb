###
# middleman-casper configuration
###

config[:casper] = {
  blog: {
    url: 'http://www.thehopelessroamantic.com',
    name: 'The Hopeless Roamantic',
    description: 'Making travel a daily part of your life',
    date_format: '%d %B %Y',
    navigation: true,
    logo: 'the-hopeless-roamantic-logo.png' # Optional
  },
  author: {
    name: 'Ryan',
    bio: '<p>Growing up, I was often found ‘roaming’. One time, my family casually found me taking a stroll on the other side of my grandma’s pretty ghetto suburban town with my cousin when I was just 3 years old (she was 2). Other times, my sister and I would roam through the dump in the back of our house and make our own homes using the trash (including a highly-used toilet seat), reeling in the early buzz of independence.</p>

<p>From a young age, wandering wasn’t just something that brought me excitement, it was also a coping mechanism for my “nerves”, something I would now equate to extreme anxiety. When all of my senses were alert, constantly processing the new things it was seeing, I never had time to think about anything else.</p>

<hr><p>At 21, I drove over the rail road tracks that lead out of my boring neighborhood for the very last time, and boarded my ass on trip to Taiwan. My memories since 21 make me want to kiss every part of this Earth and thank it for my wandering curiosity. Since then, I haven’t really gone back to the US except for a visit here and there.</p>

<hr><p>Now at 27, I find myself constantly in a state of guilt that I am unable to settle. I am trying though. I am now living in Berlin, paying rent on time, holding down a part-time job teaching programming (a topic I honestly don’t know enough about to be teaching) and freelancing, going to the gym on the tri-weekly, but regardless of this “growth”, the nerves are back in fuller force than normal. I am realizing the trigger has a lot to do with stagnation and a whole lot to do with wandering away from my values centered around roaming and freedom.</p>

<hr><p>So with the commencement of “The Hopeless Roamantic”, I have decided to embrace my need to wander through unfiltered and honest storytelling. I am here to remind you that living a life of constant roaming is okay, to inspire spontaneous travel, to learn to laugh at the failures centered around travel, and to expose, embrace, and actively deal with the beautiful flaws we have as humans.</p>

<p>This blog is for anyone who:</p>
<ul>
<li style="text-align: left;">Has the travel bug and likes off-the-beaten-track style travel</li>
<li style="text-align: left;">Wants inspiration for their next trip</li>
<li style="text-align: left;">Anti-settlers</li>
<li style="text-align: left;">Doesn’t want to be misguided by other travel blogger’s constant state of eurphoria when traveling</li>
<li style="text-align: left;">Is afraid to take the first steps in traveling</li>
<li style="text-align: left;">Suffers from bouts of anxiety, depression, and restlessness</li>', # Optional
    location: nil, # Optional
    website: nil, # Optional
    gravatar_email: nil, # Optional
    twitter: nil # Optional
  },
  navigation: {
    "Home" => "/",
    "About" => "/about",
    "Contact" => "/contact"
  }
}

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

def get_tags(resource)
  if resource.data.tags.is_a? String
    resource.data.tags.split(',').map(&:strip)
  else
    resource.data.tags
  end
end

def group_lookup(resource, sum)
  results = Array(get_tags(resource)).map(&:to_s).map(&:to_sym)

  results.each do |k|
    sum[k] ||= []
    sum[k] << resource
  end
end

tags = resources
  .select { |resource| resource.data.tags }
  .each_with_object({}, &method(:group_lookup))

tags.each do |tagname, articles|
  proxy "/tag/#{tagname.downcase.to_s.parameterize}/feed.xml", '/feed.xml',
    locals: { tagname: tagname, articles: articles[0..5] }, layout: false
end

proxy "/author/#{config.casper[:author][:name].parameterize}.html",
  '/author.html', ignore: true

# General configuration

###
# Helpers
###

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

# Pretty URLs - https://middlemanapp.com/advanced/pretty_urls/
activate :directory_indexes

# Middleman-Syntax - https://github.com/middleman/middleman-syntax
set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, footnotes: true,
  link_attributes: { rel: 'nofollow' }, tables: true
activate :syntax, line_numbers: false

# Middleman-Sprockets - https://github.com/middleman/middleman-sprockets
activate :sprockets

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Ignoring Files
  ignore 'javascripts/_*'
  ignore 'javascripts/vendor/*'
  ignore 'stylesheets/_*'
  ignore 'stylesheets/vendor/*'
end
