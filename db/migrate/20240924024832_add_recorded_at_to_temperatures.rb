class AddRecordedAtToTemperatures < ActiveRecord::Migration[7.0]
  def change
    add_column :temperatures, :recorded_at, :datetime
  end
end
