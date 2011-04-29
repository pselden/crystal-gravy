(function($) {

  $('#edit_profile').submit(function(){
    var $this = $(this);

    $.ajax({
      url: $this.attr('action'),
      type: $this.attr('method'),
      data: "edit_profile="+$this.serialize(),
      success:  function (data) {
        if(data.error)
        {
          for (var i = 0, len = data.errors.length; i < len; i++)
          {
            alert(data['errors'][i]);
          }
        } else {
          alert("succss!");
        }
      }
    });
  return false;
});

})(jQuery);