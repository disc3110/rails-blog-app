class AddCountersDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :postsCounter, 0
    change_column_default :posts, :likesCounter, 0
    change_column_default :posts, :commentsCounter, 0
  end
end
