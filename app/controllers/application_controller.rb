require 'page_data_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include PlaylistsHelper
  before_filter :append_custom_view_paths, :export_i18n_messages, :set_locale
  attr_reader :template, :stylesheets, :javascripts

  self.responder = PageDataResponder
  respond_to :html, :json, :pd

  def initialize
    @stylesheets = []
    @javascripts = []
    super
  end

  protected
    def append_stylesheet *stylesheets
      @stylesheets += stylesheets
    end

    def append_javascript *javascripts
      @javascripts += javascripts
    end

    def redirect_to(options = {}, response_status = {})
      respond_to do |format|
        format.pd { render :json => {:redirect => options} }
        format.any { super }
      end
    end

  private
    def set_locale
      I18n.locale = "en" #TODO: get current user's locale or default
    end

    def export_i18n_messages
      SimplesIdeias::I18n.export! if Rails.env.development?
    end

    def append_custom_view_paths
      append_view_path("#{Rails.root}/public/handlebars")
    end
end
