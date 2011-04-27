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

        // deletes anything that has been added to the window object
        function washWindow(){
            var badGuys = window.delta();
            jQuery.each(badGuys, function (n, i) {
                try {
                    if (delete window[i]) return;
                    window[i] = undefined;
                }
                catch (e) {
                    return;
                }
            });
        }

        this.removeAssets = function() {
            $('link.page-css, script.page-js').remove();
            washWindow();
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

        // do not run the route on initial page load
        var runOnce = false;
        // catch all path
        this.get(/.*/, function(context) {
            if(!runOnce) { runOnce = true; return; }
            var route = context.path;
            var parameters = "";
            if (route.indexOf("?")!=-1){
                var temp =  route.split("?");
                route = temp[0];
                parameters = "?"+temp[1];
            }
            $.ajax({
                url: route + ".pd" + parameters,
                success: function (pageData) {
                    if(pageData.redirect) {
                        // Fetch the State Objects
                        History.replaceState({},"",pageData.redirect);
                        context.redirect(pageData.redirect);
                        //app.trigger("location-changed");
                        return;
                    }

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

        $.comm.listen('location.href', function(location){
           app.setLocation(location);
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

    $(document).ready(function() {
        I18n.locale = currentLocale || "en";
        app.run(true);
        new MusicPlayer("#music-player");
        new LoginPopup($('#header a.login'));
    });
})();

