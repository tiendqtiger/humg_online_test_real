class QuestionBank
  include Mongoid::Document
  field :title, type: String
  field :answer, type: Array
  field :answer_true, type: Array
  field :level, type: String
  belongs_to :user, inverse_of: :questions_bank
  belongs_to :subject, inverse_of: :questions_bank
end
