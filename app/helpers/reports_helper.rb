module ReportsHelper
  def reports_list_columns
    header = [
      {label: t('report.name')},
      {label: t('report.glucose_level')},
      {label: t('report.created_at')},
    ]
    header << [{label: ''} ] if params[:controller] == 'reports'   	
  	return header.flatten
  end

  def submit_btn_text_r(object)
	 return  object.new_record? ? 'Add' : 'Update'
  end

  def get_title(type)
  	if type == 'monthly'
  		"Monthly Report"
  	elsif type == 'daily'
  		"Daily Report"
  	else
  		"Month to Date Report"
  	end			
  end

end