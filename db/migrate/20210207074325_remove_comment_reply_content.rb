class RemoveCommentReplyContent < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :reply_content
  end
end
