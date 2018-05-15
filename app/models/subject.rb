class Subject
  include Mongoid::Document
  field :name, type: String
  field :code, type: String
  has_many :questions_bank, class_name: "QuestionBank"
  has_many :exams, class_name: "Exam"
  
end
