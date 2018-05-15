class ExamThread
  include Mongoid::Document
  field :code, type: String
  belongs_to :exam, inverse_of: :exam_threads
  has_many :questions, class_name: "Question"
  has_many :students, class_name: "Student"
end
