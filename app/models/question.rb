class Question
  include Mongoid::Document
  belongs_to :question_bank
  belongs_to :exam_thread, inverse_of: :questions
end
