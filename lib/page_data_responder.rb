require 'page_data'
require 'handlebars/handlebars_rails'

class PageDataResponder < ActionController::Responder
  def initialize(controller, resources, options={})
    super
    @partials = options.delete(:partials) || {}
  end

  def to_pd
    render :json => PageData.new(template, partials, stylesheets, javascripts, resource)
  end

  def to_html
    register_handlebars_partials
    super
  end

  private
    def register_handlebars_partials
      @partials.each do |name, source|
          source = "#{source}.hbs"
          source = File.join(Rails.root, '/public/handlebars/partials', source)
          partial = File.read(source)
          Handlebars::TemplateHandler.register_partial(name, partial)
      end
    end

    def partials
      result = Hash.new
      @partials.each do |name, source|
        result[name] = compute_path(source, '/handlebars/partials', 'hbs')
      end
      result
    end

    def template
      template = controller.template || "#{controller.controller_name}/#{controller.action_name}"
      compute_path(template, '/handlebars', 'hbs')
    end

    def stylesheets
      controller.stylesheets.inject([]) do |result, stylesheet|
        result << compute_path(stylesheet, '/stylesheets', 'css')
      end
    end

    def javascripts
      controller.javascripts.inject([]) do |result, javascript|
        result << compute_path(javascript, '/javascripts', 'js')
      end
    end

    #calculates an asset id for the file based on the last modified timestamp, used for cache-busting
    def rails_asset_id source
      path = File.join(Rails.root, 'public', source)
      File.exist?(path) ? File.mtime(path).to_i.to_s : ''
    end

    def compute_path source, dir, ext
      source = "#{File.join(dir, source)}.#{ext}"
      asset_id = rails_asset_id(source)
      "#{source}?#{asset_id}"
    end
end