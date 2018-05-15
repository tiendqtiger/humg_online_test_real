require 'csv'
namespace :question_bank do
	task :import => :environment do
		list_file = Rails.root + "public/english2.csv"
	    CSV.foreach(list_file, headers: true) do |row|
    		question_bank_obj = QuestionBank.new
    		question_bank_obj.title = row[0]
    		answer = row[1].split(';')
    		answer.map!{|s| s.squish}
    		question_bank_obj.answer = answer
    		answer_true = row[2].split(';')
    		answer_true.map!{|s| s.squish.to_i}
    		question_bank_obj.answer_true = answer_true
    		question_bank_obj.level = row[3]
    		question_bank_obj.subject_id = Subject.where(:name => "Tiếng Anh 2").first.id
    		question_bank_obj.user_id = User.where(:email => "nguyenmanhcuong020895@gmail.com").first.id
    		question_bank_obj.save
    	end
	end
end