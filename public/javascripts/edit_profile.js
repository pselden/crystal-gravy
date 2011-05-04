(function($) {

  $('#edit_profile').submit(function(){
    var $this = $(this)
    method = $this.attr('method')
    $button = $this.find('button');
    $button.attr('disabled', 'true');

    $.ajax({
      url: $this.attr('action'),
      type: method,
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
          if(method == "POST")
          {
            $this.attr('method', 'PUT')
            .attr('action', '/profiles/update');
          }
        }
      }
    });
    return false;
  });

})(jQuery);