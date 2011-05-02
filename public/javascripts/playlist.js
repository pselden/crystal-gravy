(function($) {
        var $settings = $('#settings');
	$('#formSubmit').click(function(e){
		$.ajax({
                    url: '/playlists',
                    type: 'post',
                    data: $(this.form).serialize(),
                    success:  function (data) {
                            success(data);
                    },
                    error: function(){
                        error();
                    }
		});
		return false;
	});
        
        $settings.click(function(e){
            $.comm.send('location.href', $settings.data('editpath'));
            return false;
        })
        
        function success(data){
            if (!data.error){
                $.comm.send('location.href', data.playlistpath);
            } else {
                error(data);
            }
                
        }
        
        function error(data){
            
        }
})(jQuery);