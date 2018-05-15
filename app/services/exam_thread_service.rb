class ExamThreadService
	def create_thread exam_id
		exam_obj = Exam.where(:id => exam_id).first
		thread_detail = ExamThreadDetail.where(:exam_id => exam_id).first
		threads_number = thread_detail.threads_number
		total_question_for_thread = thread_detail.total_question_for_thread
		thread_detail_easy = {
			:subject_id => exam_obj.subject_id,
			:level => 'easy',
			:number_question => thread_detail.easy_question_number
		}
		thread_detail_normal = {
			:subject_id => exam_obj.subject_id,
			:level => 'normal',
			:number_question => thread_detail.normal_question_number
		}
		thread_detail_hard = {
			:subject_id => exam_obj.subject_id,
			:level => 'hard',
			:number_question => thread_detail.hard_question_number
		}

		for i in 1..threads_number
			thread_obj = ExamThread.new
			thread_obj.code = "10#{i}"
			thread_obj.exam_id = exam_obj.id
			thread_obj.save
			total_question_id = put_out_question(thread_detail_easy) + put_out_question(thread_detail_normal) + put_out_question(thread_detail_hard)
			# binding.pry
			total_question_id.each do |a|
				question_obj = Question.new
				question_obj.question_bank_id = a
				question_obj.exam_thread_id = thread_obj.id
				question_obj.save
				# binding.pry
			end
			
		end
		return true
	end

	
	def put_out_question params
		subject_id = params[:subject_id]
		level = params[:level]
		number_question = params[:number_question]
		list_question = Array.new
		list_question_search = QuestionBank.where(:subject_id => subject_id, :level => level)
		list_index = list_question_search.length
		while list_question.length <= number_question-1
			rand_index = rand(0...list_index)
			list_question.push(list_question_search[rand_index].id)
			list_question = list_question.uniq
		end
		list_question
	end
end