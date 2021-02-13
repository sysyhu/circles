class AddCommentReplies < ActiveRecord::Migration[5.1]
  def change
  	add_column :comments, :reply_content, :string
  end
end
