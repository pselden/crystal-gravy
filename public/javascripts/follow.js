(function($) {

  $('#follow_unfollow').click(function(){
    var $this = $(this),
        user_id = $this.attr('data-following_id'),
        action = ($this.attr('data-icon') == "+") ? "follow" : "unfollow";
    $this.attr('disabled', 'disabled');
    $.ajax({
      url: (action == "follow") ? "/followings/create" : "/followings/destroy",
      type: (action == "follow") ? "post" : "delete",
      data: "following_id="+user_id,
      success:  function () {
        $this.removeAttr('disabled');
        if (action == "follow")
        {
          $this.attr('data-icon', '-')
            .text('Unfollow')
            .removeAttr('class');
        } else {
           $this.attr('data-icon', '+')
            .text('Follow')
            .attr('class', 'primary');
        }
      }
  });
});
  
})(jQuery);