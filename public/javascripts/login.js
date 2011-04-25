var LoginPopup;

(function(){
    // opens a popup window in the center of the screen with the given url
    function popupCenter(url, width, height, name) {
      var left = (screen.width/2)-(width/2);
      var top = (screen.height/2)-(height/2);
      return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
    }

    LoginPopup = function(loginLink){
      var loginDialog = $('#login-dialog');
      loginDialog.find('a.auth-popup').click(function() {
        popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
        return false;
      });

      loginLink.click(function(){
         loginDialog.dialog({
             title: "Log in",
             modal: true
         });
         return false;
      });
    };
})();