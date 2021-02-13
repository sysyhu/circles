class User < ApplicationRecord

	#一、校验
	#1、用户名
	validates :username, presence: {message: "用户名不能为空"}
	validates :username, uniqueness: {message: "用户名已存在"}
	#2、密码
	#validates :password, presence: {message: "密码不能为空"}
	#validates :password, length: {minimum: 6, message: "密码不能少于 6 位"}
	#2.1 注册密码是否合法
	attr_accessor :password
	attr_accessor :password_confirmation
	validate :validate_password, on: :create
	before_create :set_password
	#2.2 登录密码验证
	def self.authenticate username, password
		user = find_by(username: username)
		if user and user.valid_password?(password)
			user
		else
			nil
		end
	end

	def valid_password? password
		self.crypted_password == Digest::SHA256.hexdigest(password + self.salt)
	end

	#二、Associations
	has_many :blogs
	has_many :public_blogs, -> {where(is_public: true)},
		class_name: "Blog"
	has_one :latest_blog, -> { order("id desc")}, 
		class_name: :Blog
	has_many :comments

	
	#三、Callback
	#1、储存前把 username 设置为小写  
	before_save :update_username



	private
	def update_username
		self.username = self.username.downcase
	end

	def validate_password
		if self.password.blank?
			self.errors.add(:password, "密码不能为空")
			return false
		end

		if self.password.length < 6
			self.errors.add(:password, "密码不能少于6位")
			return false
		end

		unless self.password == self.password_confirmation
			self.errors.add(:password_confirmation, "密码不一致")
			return false
		end

		return true
	end

	def set_password
		self.salt = Time.now.to_i
		self.crypted_password = Digest::SHA256.hexdigest(self.password + self.salt)
	end

end










