class QuestionBankController < ApplicationController
  before_action :define_pagetitle, only: [:list_question_bank_show, :detail_question_bank]
  before_action :get_subject, only: [:list_question_bank_show, :detail_question_bank]
  before_action :student_validate
  
  def list_question_bank_show
  	if @current_user.role == "user"
  		@list_question_bank = @current_user.questions_bank
  	else
  		@list_question_bank = QuestionBank.all
  	end
  	@list_question_bank = @list_question_bank.page(params[:page])
  	@page = params[:page]
  	# binding.pry
  	
  end

  def detail_question_bank
  	question_id = params[:id]
  	@question_obj = QuestionBank.where(:id => question_id).first
  	# binding.pry
  end

  def student_validate
    if @current_user.present? && @current_user.role == "student"
      redirect_to "/warning/not_found"
    end
  end

end
