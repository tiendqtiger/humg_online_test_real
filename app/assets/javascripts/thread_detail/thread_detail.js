$(document).ready(function(){
	$('#update_config_thread').click(function(){
		var exam_id = $(this).val();
		var thread_number = $('#thread_number').val();
		var total_question_for_thread = $('#total_question_for_thread').val();
		var easy_question_number = $('#easy_question_number').val();
		var normal_question_number = $('#normal_question_number').val();
		var hard_question_number = $('#hard_question_number').val();
		$.ajax({
			url: '/exam_thread/update_detail_thread',
			type: 'POST',
			data: {
				exam_id: exam_id,
				thread_number: thread_number,
				total_question_for_thread: total_question_for_thread,
				easy_question_number: easy_question_number,
				normal_question_number: normal_question_number,
				hard_question_number: hard_question_number
			},
			success: function(response){
				new PNotify({
                        title: 'Success!',
                        text: response['message'],
                        type: response['noti']
                    });
			},
			error: function(response){
				new PNotify({
                        title: 'Oh No!',
                        text: response['message'],
                        type: response['noti']
                    });
			}
		});
	});
});