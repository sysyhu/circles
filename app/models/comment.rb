class Comment < ApplicationRecord
	#二、Associations
	belongs_to :user
	belongs_to :blog

	has_many :replies, class_name: "Comment", 
		foreign_key: "commented_id"
	belongs_to :commented, class_name: "Comment", optional: true
end
