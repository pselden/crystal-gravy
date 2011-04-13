class PageData
  def initialize(template, partials, stylesheets, javascripts, data)
    @template = template
    @partials = partials
    @stylesheets = stylesheets
    @javascripts = javascripts
    @data = data
  end
end