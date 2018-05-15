Rails.application.routes.draw do



  get 'user/update_show'

  devise_for :users, path: 'auth'
  
  root :to => 'exam#filter_show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :exam do
    collection do
      get 'filter_show', to: 'exam#filter_show'
      get 'create_show', to: 'exam#create_show'
      post 'create_exam', to: 'exam#create_exam'
      post 'update_exam', to: 'exam#update_exam'
      post 'student_on_flag', to: 'exam#student_on_flag'
      post 'student_off_flag', to: 'exam#student_off_flag'
      post 'update_happening_status', to: 'exam#update_happening_status'
      post 'read_student', to: 'exam#read_student'
      post 'upload', to: 'exam#upload'
    end
    member do
      get 'info_show', to: 'exam#info_show'
      get 'task_detail', to: 'exam#task_detail'
    end
  end

  resources :subject do
    collection do
      get 'list_subject_show', to: 'subject#list_subject_show'
      post 'delete_subject', to: 'subject#delete_subject'
      post 'update_subject', to: 'subject#update_subject'
      post 'create_subject', to: 'subject#create_subject'
    end
    member do
      
    end
  end

  resources :question_bank do
    collection do
      get 'list_question_bank_show', to: 'question_bank#list_question_bank_show'
    end
    member do
      get 'detail', to: 'question_bank#detail_question_bank'
    end
  end

  resources :exam_thread do
    collection do
      post 'update_detail_thread', to: 'exam_thread#update_detail_thread'
      post 'create_exam_thread', to: 'exam_thread#create_exam_thread'
      
    end
    member do
      get 'exam_thread_show', to: 'exam_thread#exam_thread_show'
    end
  end

  resources :student do
    collection do
      get 'enter_exam', to: 'student#enter_exam'
      get 'login', to: 'student#login'
      get 'check_status_exam', to: 'student#check_status_exam'
      get 'question_student', to: 'student#question_student'
      post 'submit_and_mark', to: 'student#submit_and_mark'
    end
    member do
      
    end
  end

  resources :warning do
    collection do
      get 'not_found', to: 'warning#not_found'
    end
    member do
      
    end
  end

  resources :user do
    collection do
      get 'update_show', to: 'user#update_show'
    end
    member do
      
    end
  end

end
