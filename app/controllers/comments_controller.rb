class CommentsController < ApplicationController

	before_action :auth_user

	def index

	end

	def new
		@comment = Comment.new
	end

	def create
		@blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.new(comment_attrs)
    @comment.user = current_user
    #binding.pry
		if @comment.save
			flash[:notice] = "comment 创建成功"
			redirect_to blog_path(@blog)
		else
			flash[:notice] = "comment 创建失败"
			redirect_to blog_path(@blog)
		end
	end

	def destroy
		@comment = Comment.find params[:id]
		@comment.destroy
		redirect_to blog_path(@comment.blog)
	end

	private
	def comment_attrs
		params.require(:comment).permit(:content, :commented_id)
	end

end
