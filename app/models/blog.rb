class Blog < ApplicationRecord

	#一、校验
	validates :title, presence: {message: "标题不能为空"}
	validates :content, presence: {message: "内容不能为空"}
	validates :user_id, presence: {message: "用户不能为空"}

	#其他校验，如：有没有铭感词汇黄赌毒、禁言用户不得发 blog
	
	#二、Associations
	belongs_to :user, dependent: :destroy
	has_many :blogs_tags, class_name: "BlogsTags" #has_and_belongs_to_many :tags(没建立 blogs_tags 模型
	has_many :tags, through: :blogs_tags
	has_many :comments

	

	def tags_string= one_tags
		one_tags.split(',').each do |tag|
			one_tag = Tag.find_by(title: tag)
			one_tag = Tag.new(title: tag) unless one_tag
			self.tags << one_tag
		end
	end

end
