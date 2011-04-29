(function($) {
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
        
        function success(data){
            if (!data.error){
                $.comm.send('location.href','/');
            } else {
                error(data);
            }
                
        }
        
        function error(data){
            
        }
})(jQuery);