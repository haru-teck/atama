class CreateAdditions < ActiveRecord::Migration[7.0]
  def change
    create_table :additions do |t|
      t.string :eat
      t.string :moisture
      t.string :puke
      t.text   :memo


      t.timestamps
    end
  end
end
