class AddCommentSelfJoin < ActiveRecord::Migration[5.1]
  def change
  	add_column :comments, :commented_id, :int
  end
end
