require 'csv'
namespace :subject do
	task :import => :environment do
		list_file = Rails.root + "public/list_subject.csv"
	    CSV.foreach(list_file, headers: true) do |row|
    		Subject.create(:name => row[1], :code => row[0])
    	end
	end
end