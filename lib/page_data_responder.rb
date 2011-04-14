require 'page_data'
require 'handlebars/handlebars_rails'

class PageDataResponder < ActionController::Responder
  HANDLEBARS_FOLDER = "handlebars"

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
      @partials.each do |name, partial_name|
          partial_path = compute_partial_path partial_name
          full_path = File.join(Rails.root, "public", partial_path)
          partial = File.read(full_path)
          Handlebars::TemplateHandler.register_partial(name, partial)
      end
    end

    def partials
      result = Hash.new
      @partials.each do |name, partial_name|
        partial_path = compute_partial_path partial_name
        result[name] = compute_path(partial_path)
      end
      result
    end

    def template
      template = controller.template || "#{controller.controller_name}/#{controller.action_name}"
      compute_path(template, "/" + HANDLEBARS_FOLDER, 'hbs')
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

    def compute_path source, dir = '', ext = nil
      source = File.join(dir, source)
      source += ".#{ext}" if ext
      asset_id = rails_asset_id(source)
      "#{source}?#{asset_id}"
    end

    # returns the path to a partial (without the assets directory)
    # example: compute_partial_path "shared/home" would return "
    def compute_partial_path partial_name
        directory = File.dirname partial_name if partial_name.include?("/")
        directory ||= ''
        directory = File.join(controller.controller_name, directory) if directory.starts_with?("/") || directory == ''
        file_name = "_#{File.basename partial_name}.hbs"
        File.join(HANDLEBARS_FOLDER, directory, file_name)
    end
end