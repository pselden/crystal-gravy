module ApplicationHelper

  def link_to_sign_in provider
    link_to provider.to_s.capitalize, "/auth/#{provider}", :class => "auth-popup", :"data-width" => 775, :"data-height" => 450
  end

  # creates stylesheet link tags for page specific css
  def page_stylesheets
    stylesheet_link_tag @stylesheets, :class => 'page-css'
  end

  # creates script tags for page specific javascript
  def page_javascripts
    javascript_include_tag @javascripts, :class => 'page-js'
  end

  # a translation helper for handlebars templates
  def ht key, *values, context
    hash = Hash.new
    i = 0
    values.each do |val|
      hash[i.to_s.to_sym] = val
      i += 1
    end
    t key, hash
  end

  def javascript_include_translations
    javascript_include_tag ["i18n", "translations/#{I18n.locale.to_s}.js"]
  end
  
  def title 
	site_title = "Zipper"
	if  @title.nil?
		site_title
	else
		"#{site_title } - #{@title}"
	end
  end
end
