require 'page_data'
require 'handlebars/handlebars_rails'

class PageDataResponder < ActionController::Responder
  TEMPLATE_FOLDER = "handlebars"
  TEMPLATE_EXT = "hbs"

  def initialize(controller, resources, options={})
    super
    @partials = options.delete(:partials) || {}
  end

  def to_pd
    public_template = compute_asset_path(template, "/" + TEMPLATE_FOLDER, TEMPLATE_EXT)
    render :json => PageData.new(public_template, partials, stylesheets, javascripts, resource)
  end

  def to_html
    # turn all of the respond_with variables into instance variables so they can be used in the template
    resource.each do |name, value|
      variable_name = "@#{name}"
      controller.instance_variable_set(variable_name, value)
    end if resource.is_a?(Hash)

    register_handlebars_partials
    render template
  end

  private
    def register_handlebars_partials
      @partials.each do |name, partial_name|
          partial_path = compute_template_path partial_name, true
          full_path = File.join(Rails.root, "public", partial_path)
          partial = File.read(full_path)
          Handlebars::TemplateHandler.register_partial(name, partial)
      end
    end

    def partials
      return @public_partials if @public_partials
      @public_partials = Hash.new
      @partials.each do |name, partial_name|
        partial_path = compute_template_path partial_name, true
        @public_partials[name] = compute_asset_path(partial_path, TEMPLATE_FOLDER, TEMPLATE_EXT)
      end
      @public_partials
    end

    def template
      return @template if @template
      template = controller.template || "#{controller.controller_name}/#{controller.action_name}"
      @template = compute_template_path(template)
    end

    def stylesheets
      return @stylesheets if @stylesheets
      @stylesheets = controller.stylesheets.inject([]) do |result, stylesheet|
        result << compute_asset_path(stylesheet, '/stylesheets', 'css')
      end
    end

    def javascripts
      return @javascripts if @javascripts
      @javascripts = controller.javascripts.inject([]) do |result, javascript|
        result << compute_asset_path(javascript, '/javascripts', 'js')
      end
    end

    #calculates an asset id for the file based on the last modified timestamp, used for cache-busting
    def rails_asset_id source
      path = File.join(Rails.root, 'public', source)
      File.exist?(path) ? File.mtime(path).to_i.to_s : ''
    end

    def compute_asset_path source, dir = '', ext = nil
      source += ".#{ext}" if ext
      source = File.join(dir, source)
      asset_id = rails_asset_id(source)
      "#{source}?#{asset_id}"
    end

    # returns the path to a template (without the assets directory)
    # if is_partial is true, prepends _ to the file
    def compute_template_path template_name, is_partial=false
       if template_name.include?("/")
         prefix = File.dirname template_name
       else
         prefix = controller.controller_name
       end
        file_name = "#{File.basename template_name}"
        file_name = "_#{file_name}" if is_partial
        File.join(prefix, file_name)
    end

end