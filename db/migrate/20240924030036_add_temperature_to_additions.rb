class AddTemperatureToAdditions < ActiveRecord::Migration[7.0]
  def change
    add_reference :additions, :temperature, null: false, foreign_key: true
  end
end
