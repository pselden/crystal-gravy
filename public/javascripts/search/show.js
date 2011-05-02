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
    
    
    Handlebars.registerHelper("firstOfArray", function(array,fn, inverse){
            if (array || array.length>0){ 
                return fn(array[0]);
            }
            else{
                return inverse(this);
            }
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
    
    
})(jQuery,window)