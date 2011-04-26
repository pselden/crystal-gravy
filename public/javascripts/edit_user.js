(function($) {
  $('#edit_user').submit(function(){
    $.ajax({
      url: this.action,
      type: 'put',
      data: $(this).serialize(),
      success:  function (data) {
        if(data.errors)
        {
            alert('asdfs');
        } else {
            alert('Success!');
        }
      }
    });
    return false;
  });

})(jQuery);