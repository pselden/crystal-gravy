// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// manages assets (stylesheets, scripts) between page transitions

(function(){
    var AssetManager = function() {
        this.addStylesheets = function(sources) {
           var stylesheets ='';
           $.each(sources, function(i, href){
                stylesheets += '<link type="text/css" rel="stylesheet" class="page-css" href="' + href + '" />';
           });

           $('head').append(stylesheets);
        };

        this.addJavascripts = function(sources) {
            var scripts = '';
            $.each(sources, function(i, href) {
                scripts += '<script type="text/javascript" class="page-js" src="' + href + '" /></script>';
            });

            $('body').append(scripts);
        };

        this.removeAssets = function() {
            $('link.page-css, script.page-js').remove();
        };
    };

    var app = $.sammy('#main', function() {
        var assetManager = new AssetManager();

        this.use('Handlebars', 'hbs');
        this.setLocationProxy(new Sammy.HistoryProxy(this));

        // handlebars translate helper
        // takes in a key and an optional array of arguments
        Handlebars.registerHelper('ht', function(key) {
            var values = {};
            for (var i = 1; i < arguments.length; i += 1) {
                values[i - 1] = arguments[i];
            }
            return I18n.t(key, values);
        });

        // catch all path
        this.get(/.*/, function(context) {
            var route = context.path;
            $.ajax({
                url: route + ".pd",
                success: function (pageData) {
                    $.when.apply($, loadPartials(pageData.partials)).then(function(){
                        context.partial(pageData.template, pageData.data).then(function(){
                            assetManager.removeAssets();
                            assetManager.addStylesheets(pageData.stylesheets);
                            assetManager.addJavascripts(pageData.javascripts);
                        });
                    });
                },
                error: function(jqXHR, textStatus) {
                    alert(jqXHR.status + " " + textStatus);
                },
                dataType: 'json'
            });
        });
    });

    function loadPartials(partials){
        var deferreds = [];
        $.each(partials, function(name, source){
           var deferred = $.get(source, function(partial){
                Handlebars.registerPartial(name, partial);
           });
           deferreds.push(deferred);
        });

        return deferreds;
    }

    // opens a popup window in the center of the screen with the given url
    function popupCenter(url, width, height, name) {
      var left = (screen.width/2)-(width/2);
      var top = (screen.height/2)-(height/2);
      return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
    }

    $(document).ready(function() {

        I18n.locale = currentLocale || "en";

        app.run();

        $("a.auth-popup").click(function() {
            popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
            return false;
        });
    });
})();

