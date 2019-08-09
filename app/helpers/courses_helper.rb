module CoursesHelper
   def courses_list_columns
    [
      {label: t('course.name')},
      {label: t('course.description')},
      {label: t('course.active')},
      {label: t('course.position')},
    ]
  end
end
