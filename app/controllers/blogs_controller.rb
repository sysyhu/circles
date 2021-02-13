class BlogsController < ApplicationController

	before_action :auth_user, except:[:index, :show]

	def index
		@blogs = Blog.all.where(is_public: true).includes(:tags, :user)
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = current_user.blogs.new(blog_attrs) #@blog = Blog.new(blog_attrs)
		#@blog.user = current_user #@blog.user_id = current_user.id	
		if @blog.save
			flash[:notice] = "blog 创建成功"
			redirect_to blogs_path
		else
			flash[:notice] = "创建失败"
			render action: :new
		end
	end  

	def show
		@blog = Blog.find params[:id]
	end

	def edit
		@blog = Blog.find params[:id]
		render action: :new
	end

	def update
		@blog = Blog.find params[:id]
		@blog.update_attributes blog_attrs
		if @blog.save
			@blog.tags.destroy_all
			flash[:notice] = "更新成功"
			redirect_to blogs_path
		else
			flash[:notice] = "更新失败"
			render action: :new
		end
	end

	def destroy
		@blog = Blog.find params[:id]
		@blog.destroy
		redirect_to blogs_path
	end


	private

	def blog_attrs
		params.require(:blog).permit(:title, :content, :is_public, :tags_string )
	end


end
