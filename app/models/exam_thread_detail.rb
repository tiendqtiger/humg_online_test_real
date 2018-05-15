class ExamThreadDetail
  include Mongoid::Document
  field :threads_number, type: Integer
  field :total_question_for_thread, type: Integer
  field :easy_question_number, type: Integer
  field :normal_question_number, type: Integer
  field :hard_question_number, type: Integer
  belongs_to :exam
end
