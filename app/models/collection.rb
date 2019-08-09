class Collection < ApplicationRecord

	validates :amount, :reference, :collection_date, presence: true

end
