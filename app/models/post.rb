# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  content    :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
	validates :title, :url, :content, :user, presence: true

	belongs_to :user, inverse_of: :posts

	has_many :post_subs, 
	class_name: "PostSub",
	foreign_key: :post_id, 
	primary_key: :id, 
	inverse_of: :post, 
	dependent: :destroy

	has_many :subs, through: :post_subs, source: :sub

	has_many :comments, inverse_of: :post

	def comments_by_parent
		comments_by_parent = Hash.new {|hash, key| hash[key] = []}

		comments.each do |comment|
			comments_by_parent[comment.parent_comment_id] << comment
		end

		comments_by_parent
	end
end
