class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :decentralization
  # before_action :student_validate, except: [:enter_exam, :check_status_exam, :question_student]
  
  
  def layout_by_resource
    if devise_controller?
      "new_login"
    else
      "application"
    end
  end
  
  def decentralization
    @current_user = current_user
    if @current_user.present?
      con_ac = params["controller"]+"#"+params["action"]
      if (@current_user.role == "user") &  (ADMIN.include? con_ac)
        render :file => 'public/deny.html', :layout => false
      end
    end
  end

  def define_pagetitle
    case params["action"]
    when "filter_show"
      @title_page = "Kỳ Thi"
    when "create_show"
      @title_page = "Tạo Kỳ Thi"
    when "list_subject_show"
      @title_page = "Danh Sách Môn"
    when "list_question_bank_show"
      @title_page = "Ngân Hàng Câu Hỏi"
    when "detail_question_bank"
      @title_page = "Chi Tiết Câu Hỏi"
    when "update_show"
       @title_page = "Danh Sách Giảng Viên" 
    else
      @title_page = "Thông Tin Kỳ Thi"
    end
  end

  def get_subject
    @list_subject = Subject.all
  end

  def get_user
    @list_user = User.where(:role => "user").pluck(:email, :id)
  end

  def student_search
    current_user_email = @current_user.email
    @student_obj = Student.where(:email => current_user_email, :flag => true).first
  end
  
  # def student_validate
  #   # binding.pry
  #   @current_user = current_user
  #   if @current_user.present? && @current_user.role == "student"
  #     # binding.pry
  #     redirect_to "/warning/not_found"
  #     # render :file => 'public/deny.html', :layout => false
  #   end
  # end
end
