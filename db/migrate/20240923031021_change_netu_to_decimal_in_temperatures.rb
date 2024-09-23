class ChangeNetuToDecimalInTemperatures < ActiveRecord::Migration[7.0]
  def change
    change_column :temperatures, :netu, :decimal, precision: 4, scale: 1
  end
end
