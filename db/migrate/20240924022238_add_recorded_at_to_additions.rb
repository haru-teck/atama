class AddRecordedAtToAdditions < ActiveRecord::Migration[7.0]
  def change
    add_column :additions, :recorded_at, :datetime
  end
end
