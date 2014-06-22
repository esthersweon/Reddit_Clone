class Vote < ActiveRecord::Base
	validates :votable_type, :user, presence: true

	belongs_to :user, inverse_of: :votes
	belongs_to :votable, polymorphic: true
end
