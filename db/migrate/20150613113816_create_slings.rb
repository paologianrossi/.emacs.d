class CreateSlings < ActiveRecord::Migration
  def change
    create_table :slings do |t|
      t.references :brand, index: true, foreign_key: true
      t.string :name
      t.integer :weight
      t.string :colors
      t.string :blend
      t.date :release_date
      t.string :link
      t.integer :status

      t.timestamps null: false
    end
  end
end
