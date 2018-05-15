$(document).ready(function(){
	$('#email_login, #pwd_login').keypress(function(e){
		if(e.which == 13) {
        	$('#new_user').submit();
    	}
	});
});