# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string(255)      not null
#  submitter_id      :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
	validates :content, :submitter_id, :post_id, presence: true

	belongs_to :submitter, 
	class_name: "User", 
	foreign_key: :submitter_id, 
	primary_key: :id, 
	inverse_of: :comments

	belongs_to :post, inverse_of: :comments

	has_many :child_comments, 
	class_name: "Comment", 
	foreign_key: :parent_comment_id, 
	primary_key: :id

	belongs_to :parent_comment, 
	class_name: "Comment",
	foreign_key: :parent_comment_id, 
	primary_key: :id
end
