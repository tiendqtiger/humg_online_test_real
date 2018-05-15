class SubjectController < ApplicationController
  before_action :define_pagetitle, only: [:list_subject_show]
  before_action :get_subject, only: [:list_subject_show]
  skip_before_action :verify_authenticity_token, only: [:delete_subject, :update_subject, :create_subject]
  before_action :student_validate
  def list_subject_show
  end

  def delete_subject
  	subject_id = params[:subject_id]
  	subject_obj = Subject.where(:id => subject_id).first
  	if subject_obj.delete
  		render json: {status: 200, message: "Xóa thành công", noti: 'success'}, status: 200
  	else
  		render json: {status: 400, message: 'Xóa thất bại', noti: 'error'}, status: 200
  	end
  end

  def update_subject
    subject_id = params[:subject_id]
    subject_code = params[:subject_code]
    subject_name = params[:subject_name]
    subject_obj = Subject.where(:id => subject_id).first
    if subject_obj.update(:name => subject_name, :code => subject_code)
      render json: {status: 200, message: "Update thành công", noti: 'success'}, status: 200
    else
      render json: {status: 400, message: 'Update thất bại', noti: 'error'}, status: 200
    end
  end

  def create_subject
    subject_code = params[:subject_code]
    subject_name = params[:subject_name]
    subject_obj = Subject.new
    subject_obj.code = subject_code
    subject_obj.name = subject_name
    if subject_obj.save
      render json: {status: 200, message: "Thêm thành công", noti: 'success', subject_id: subject_obj.id.to_s}, status: 200
    else
      render json: {status: 400, message: 'Thêm thất bại', noti: 'error'}, status: 200
    end
  end

  def student_validate
    if @current_user.present? && @current_user.role == "student"
      redirect_to "/warning/not_found"
    end
  end
  
end
