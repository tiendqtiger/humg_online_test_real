namespace :test do
	task :run => :environment do
		subject_id = "5ae1a1ed7b858c139cde4753"
		level = "normal" 	
		number = 20
		list_question = Array.new
		list_question_search = QuestionBank.where(:subject_id => subject_id, :level => level)
		binding.pry
		list_index = list_question_search.length
		while list_question.length <= number-1
			rand_index = rand(0...list_index)
			list_question.push(list_question_search[rand_index].id)
			list_question = list_question.uniq
		end
		puts list_question.length

	end
end