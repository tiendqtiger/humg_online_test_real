class ExamThreadController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:update_detail_thread, :create_exam_thread]
	before_action :student_validate

	def update_detail_thread
		exam_thread_detail_obj = ExamThreadDetail.where(:exam_id => params[:exam_id]).first
		if exam_thread_detail_obj.blank?
			thread_detail_obj = ExamThreadDetail.new
			thread_detail_obj.threads_number = params[:thread_number].to_i
			thread_detail_obj.total_question_for_thread = params[:total_question_for_thread].to_i
			thread_detail_obj.easy_question_number = params[:easy_question_number].to_i
			thread_detail_obj.normal_question_number = params[:normal_question_number].to_i
			thread_detail_obj.hard_question_number = params[:hard_question_number].to_i
			thread_detail_obj.exam_id = Exam.where(:id => params[:exam_id]).first.id
		else
			thread_detail_obj = exam_thread_detail_obj
			thread_detail_obj.threads_number = params[:thread_number].to_i
			thread_detail_obj.total_question_for_thread = params[:total_question_for_thread].to_i
			thread_detail_obj.easy_question_number = params[:easy_question_number].to_i
			thread_detail_obj.normal_question_number = params[:normal_question_number].to_i
			thread_detail_obj.hard_question_number = params[:hard_question_number].to_i
		end
		if thread_detail_obj.save
			render json: {status: 200, message: "Config thành công", noti: 'success'}, status: 200
		else
			render json: {status: 400, message: 'Config thất bại', noti: 'error'}, status: 200
		end
	end

	def create_exam_thread
		e = ExamThreadService.new
		if e.create_thread(params[:exam_id])
			render json: {status: 200, message: "Config thành công", noti: 'success'}, status: 200
		else
			render json: {status: 400, message: 'Config thất bại', noti: 'error'}, status: 200
		end
	end

	def exam_thread_show
		@exam_thread_obj = ExamThread.where(:id => params[:id]).first
		
		render layout: false
	end

	
	def student_validate
	    if @current_user.present? && @current_user.role == "student"
	      redirect_to "/warning/not_found"
	    end
  	end


end
