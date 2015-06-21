class CreateSpecimen < ActiveRecord::Migration
  def change
    create_table :specimen do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sling, index: true, foreign_key: true
      t.string :size
      t.integer :actual_size

      t.timestamps null: false
    end
  end
end
