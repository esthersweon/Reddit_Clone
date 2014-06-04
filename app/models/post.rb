# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  content    :string(255)      not null
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
	validates :title, :url, :content, :sub_id, :user_id, presence: true
	belongs_to :sub
	belongs_to :user
end
