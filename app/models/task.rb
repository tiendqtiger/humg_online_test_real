class Task
  include Mongoid::Document
  field :student_answer, type: Array
  belongs_to :student, inverse_of: :tasks
  belongs_to :question_bank
end
