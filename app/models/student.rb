class Student < ApplicationRecord

	validates :name, :dob, :gender, :contact_number, :active, :course_ids, presence: true
	validates :contact_number, length: {maximum: 10}

	scope :active, -> { where(active: 'Y') }

	GENDER = [['Male', 'M'],['Female', 'F']]

	has_and_belongs_to_many :courses

	def is_activated?
		self.active == 'Y'
	end
end
