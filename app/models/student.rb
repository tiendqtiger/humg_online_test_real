class Student
  include Mongoid::Document
  field :name, type: String
  field :student_code, type: String
  field :class_code, type: String
  field :flag, type: Boolean
  field :email, type: String
  field :test_score, type: Float
  belongs_to :exam, inverse_of: :students
  belongs_to :user
  belongs_to :exam_thread, inverse_of: :students
  has_many :tasks, class_name: "Task"


  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open file
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
    end
    
    
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
