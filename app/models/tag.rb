class Tag < ApplicationRecord

	#一、校验
	validates :title, uniqueness: { message: "标签已存在"}

	#二、Associations
	has_many :blogs_tags, class_name: "BlogsTags" #没有遵循 convention, 手动添加 model 名
	#has_and_belongs_to_many :blogs
	has_many :blogs, through: :blogs_tags
	
end
