(function() {
    $.comm.listen('user.new', function(data) {
        var newUserDialog = $('#new-user-dialog');
        var usernameInput = newUserDialog.find('input[name="username"]').val(data.user.username);
        newUserDialog.find('form input[type="submit"]').click(function() {
            data.user.username = usernameInput.val();
            $.post(this.form.action, data, function(result) {
                if(result.errors){
                  $.each(result.errors, function(errorName, errors){
                       alert(errorName + " " + errors[0]);
                  });
                } else {
                    window.location.reload(true);
                }
            });
            return false;
        });

        newUserDialog.dialog({
            title: "I see you're new...",
            modal: true
        });
    });
})();