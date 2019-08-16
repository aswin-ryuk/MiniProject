class Course < ApplicationRecord
	
	include GenericModel
	
	validates :name, :active, presence: true
	validates :name, uniqueness: { case_sensitive: false }

	has_and_belongs_to_many :students

	scope :active, -> { where(active: 'Y') }

    after_create :add_next_position

	def is_activated?
		self.active == 'Y'
	end

end
