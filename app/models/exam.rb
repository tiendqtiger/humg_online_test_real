class Exam
  include Mongoid::Document
  field :name, type: String
  field :code, type: String
  field :created_at, type: Time, default: Time.now
  field :time_begin, type: Time
  field :time_finish, type: Time
  field :period_for, type: Integer
  field :supervisor, type: Array
  field :extra_info, type: String
  field :status, type: String, default: "pending"
  belongs_to :user, inverse_of: :exams
  belongs_to :subject, inverse_of: :exams
  has_many :exam_threads, class_name: "ExamThread"
  # belongs_to :exam_thread_detail
  has_many :students, class_name: "Student"

end
