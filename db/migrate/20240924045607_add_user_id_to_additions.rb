class AddUserIdToAdditions < ActiveRecord::Migration[7.0]
  def change
    add_reference :additions, :user, null: false, foreign_key: true
  end
end
