class AddUserIdToTemperatures < ActiveRecord::Migration[7.0]
  def change
    add_column :temperatures, :user_id, :integer
  end
end
