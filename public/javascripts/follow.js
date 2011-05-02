(function($) {

  $('#follow_unfollow').click(function(){
    var $this = $(this),
        user_id = $this.attr('data-following_id'),
        action = ($this.attr('data-icon') == "+") ? "follow" : "unfollow";
    $this.attr('disabled', 'disabled');

    $.ajax({
      url: "/relationships",
      type: (action == "follow") ? "post" : "delete",
      data: { followed_id : user_id },
      success:  function () {

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
      },
        complete: function(){
                $this.removeAttr('disabled');
        },
        mimeType: "application/json"
  });
});
  
})(jQuery);