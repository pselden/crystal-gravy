(function($) {
  
  $('#follow').click(function(){
    $this = $(this);
    $this.attr('disabled', 'true');
    $.ajax({
      url: "/followings/create",
      type: 'post',
      data: "following_id="+$this.attr('data-following_id'),
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

  $('#unfollow').click(function(){
    $this = $(this);
    $this.attr('disabled', 'true');
    $.ajax({
      url: "/followings/destroy",
      type: 'delete',
      data: "following_id="+$this.attr('data-following_id'),
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