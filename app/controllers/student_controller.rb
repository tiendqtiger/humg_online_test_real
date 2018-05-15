class StudentController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:submit_and_mark]
	before_action :student_search, only: [:check_status_exam, :question_student, :enter_exam, :submit_and_mark]
	def login
		render layout: false
	end

	def enter_exam
		if @student_obj.present?
			@student_send = @student_obj
		end
		render layout: false
	end

	def check_status_exam
		if @student_obj.present?
			exam_obj = @student_obj.exam
			if exam_obj.status == "happening"
				redirect_to "/student/question_student"
			else
				redirect_to "/student/enter_exam"
			end
		else
			redirect_to "/student/enter_exam"
		end
	end

	def question_student
		@exam_thread_obj = @student_obj.exam_thread
		render layout: false
	end

	def submit_and_mark
		list_task_student = params.except(:controller, :action)
		if list_task_student.present?
			list_task_student.each do |key, value|
				task_obj = Task.new
				task_obj.question_bank_id = QuestionBank.where(:id => key).first.id
				task_obj.student_id = @student_obj.id
				task_obj.student_answer = value.map {|e| e.to_i}
				task_obj.save
			end
		end
		@student_obj.test_score = evaluation_test_score @student_obj
		@student_obj.save
		@student_send = @student_obj.test_score
		render layout: false
	end

	def evaluation_test_score params
		i = 0
		list_task = params.tasks
		list_task.each do |t|
			if t.student_answer == t.question_bank.answer_true
				i = i + 1
			end
		end
		total_question = ExamThreadDetail.where(:exam_id => params.exam.id).first.total_question_for_thread
		score = (((10.to_f)/total_question)*i).round(1)
		return score
	end
end
