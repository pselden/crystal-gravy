(function($) {

  $('#edit_profile').submit(function(){
    var $this = $(this);
        $button = $this.find('button');
    $button.attr('disabled', 'true');

    $.ajax({
      url: $this.attr('action'),
      type: $this.attr('method'),
      data: $this.serialize(),
      success:  function (data) {
        $button.removeAttr('disabled');
        if(data.error)
        {
          console.log(data.errors);
          for ( var err in data.errors ) {
            $("#"+err).before("<p>"+data.errors[err]+"</p>");
          }
        } else {
          alert("succss!");
        }
      }
    });
    return false;
  });

})(jQuery);