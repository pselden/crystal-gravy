(function($,window){
       
    $("#searchExecute").click(function(e){
         var searchInputText = $("#searchInput").attr("value");
         if (searchInputText){
             var q = "?q=";
             var val = window.encodeURIComponent(searchInputText);
             var index = this.href.indexOf("?q=");
             if (index===-1){
                  this.href +=  q + val;  
             }
             else{
                 this.href = this.href.substring(0,index) + q + val;
             }
        }
        else{
            
            e.preventDefault();
            e.stopPropagation();
        }
    });
    
    
    Handlebars.registerHelper("startIndexItem", function(context,fn, inverse){
            if (context){
                if (context.entry && context.entry[context.startIndex]){
                    return fn(context.entry[context.startIndex]);
                }                
            }
            else{
                return inverse[this];
            }
    });
    
    Handlebars.registerHelper("myEach", function(context,fn, inverse){
            var ret="";
            if (context && context.entry){
                    var entry = context.entry;
                    for(var i=context.startIndex, l=entry.length; i<l; i++ ){
                              ret = ret + fn(entry[i]);                  
                    }
            }
            else{
                ret = inverse[this];
            }
            return ret;
    });
        
    Handlebars.registerHelper("ifOne", function(context,fn){
            if (context || context.length>0){ 
                if (context==="1") {
                    return fn(true);
                }
            }
            else{
                return fn(false);
            }            
    });
    
    Handlebars.registerHelper("inMinute", function(seconds){
            if (seconds || seconds.length>0){ 
                var minute = Math.floor(parseInt(seconds)/60);
                if (minute < 10) minute = "0"+minute;
                return minute;
            }
            return "";
   });
    
    Handlebars.registerHelper("inSecond", function(seconds){
            if (seconds || seconds.length>0){ 
                var second = parseInt(seconds)%60;
                if (second < 10) second = "0"+second;
                return second;
            }  
            return "";
    });
    
})(jQuery,window)