$(document).ready(function(){
	$("#check_group_question_bank").change(function () {
    	$(".check_question_bank").prop('checked', $(this).prop("checked"));
	});
});