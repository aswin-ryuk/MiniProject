class Feedback < ApplicationRecord

  validates :name, :user_comments, presence: true

end
