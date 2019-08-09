module StudentsHelper
	def students_list_columns
	    [
      {label: t('student.name')},
      {label: t('student.dob')},
      {label: t('student.gender')},
      {label: t('student.contact')},
      {label: t('student.courses')},
      {label: t('student.status')},
    ]
  end
end
