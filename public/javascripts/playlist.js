(function($) {
	$('#formSubmit').click(function(e){
		$.ajax({
				url: '/playlists/create',
				type: 'post',
				data: $(this.form).serialize(),
				success:  function (data) {
					alert(data);
				}
		});
		return false;
	});
})(jQuery);