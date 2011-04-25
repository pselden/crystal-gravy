require 'page_data'
require 'handlebars/handlebars_rails'

class PageDataResponder < ActionController::Responder
  TEMPLATE_FOLDER = "handlebars"
  TEMPLATE_EXT = "hbs"

  def initialize(controller, resources, options={})
    super
    puts resource
    @partials = options.delete(:partials) || {}
  end

  def to_pd
    render :json => PageData.new(template, partials, stylesheets, javascripts, resource)
  end

  def to_html
    # turn all of the respond_with variables into instance variables so they can be used in the template
    resource.each do |name, value|
      variable_name = "@#{name}"
      controller.instance_variable_set(variable_name, value) unless controller.instance_variable_defined? variable_name
    end

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
      compute_path(template, "/" + TEMPLATE_FOLDER, TEMPLATE_EXT)
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
       if partial_name.include?("/")
         prefix = File.dirname partial_name
       else
         prefix = controller.controller_name
       end
        file_name = "_#{File.basename partial_name}.#{TEMPLATE_EXT}"
        File.join(TEMPLATE_FOLDER, prefix, file_name)
    end
end