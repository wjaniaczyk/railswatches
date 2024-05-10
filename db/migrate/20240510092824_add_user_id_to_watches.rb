class AddUserIdToWatches < ActiveRecord::Migration[7.1]
  def change
    add_column :watches, :user_id, :integer
    add_index :watches, :user_id
  end
end
