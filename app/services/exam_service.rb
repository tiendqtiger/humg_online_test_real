class ExamService
	attr_accessor :exam
	attr_accessor :user

	def initialize(args = {})
		@exam = args[:exam]
		@user = args[:user]
	end

	def create_exam	params
		exam = params[:exam]
		user = params[:user]
		exam_obj = Exam.new
		exam_obj.name = exam[:name]
		exam_obj.code = exam[:code]
		exam_obj.subject_id = Subject.where(:id => exam[:subject_id]).first.id
		exam_obj.time_begin = exam[:time_begin]
		exam_obj.period_for = exam[:period_for]
		exam_obj.place_for = exam[:place_for]
		exam_obj.supervisor = exam[:supervisor]
		exam_obj.extra_info = exam[:extra_info]
		exam_obj.user_id = user.id
		exam_obj.save
	end

	def put_out_question
		subject_id = "5ae1a1ed7b858c139cde4753"
		level = "normal"
		number = 20
		list_question = Array.new
		list_question_search = QuestionBank.where(:subject_id => subject_id, :level => level)
		list_index = list_question_search.length
		while list_question.length <= number-1
			rand_index = rand(0...list_index)
			list_question.push(list_question_search[rand_index].id)
			list_question = list_question.uniq
		end
		list_question
	end

	def update_success_status params
		time_finish = params.time_finish.localtime("+07:00") + 1
		require 'rufus-scheduler'
		scheduler = Rufus::Scheduler.new
		scheduler.at time_finish.to_s do
				list_student = params.students
				list_student.each do |std|
					std.flag = false
					std.save
				end
				params.status = "success"
				params.save
		end
	end

end