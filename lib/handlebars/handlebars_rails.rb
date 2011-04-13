class Handlebars::TemplateHandler

  # monkey patch to add register_partial method to handlebars-rails
  def self.register_partial name, partial
    js.eval(%{
      Handlebars.registerPartial("#{name}", #{partial.inspect});
    })
  end

end