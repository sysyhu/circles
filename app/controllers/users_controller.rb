class UsersController < ApplicationController

	before_action :auth_user, only: [:index, :blogs]

	def index
		@users = User.all 
	end
			
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_attr)
  	if @user.save
  		flash[:notice] = "注册成功，请登录"
  		redirect_to new_session_path
  	else
  		render action: :new
  	end
  end

  def blogs
    @blogs = current_user.blogs
  end

  private
    def user_attr
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

end