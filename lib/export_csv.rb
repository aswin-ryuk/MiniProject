module ExportCsv 
  require 'csv'

  def generate_course_list(conditions, header)
     rows = []
    # CSV header
    rows << header
    # CSV data's rows
    conditions.each{|c| rows << [ c.name, c.description, c.active, c.position]}
    # Convert array into csv string    
    create_csv(rows)
  end
  
  def create_csv(rows, enable_quote=false)
    CSV.generate(:col_sep => ";", force_quotes: enable_quote, encoding: 'ISO-8859-1') do |csv|
      rows.each do |r|
        csv << r
      end
    end
  end

end