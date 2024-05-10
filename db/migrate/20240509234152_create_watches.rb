class CreateWatches < ActiveRecord::Migration[7.1]
  def change
    create_table :watches do |t|
      t.string :name
      t.string :description
      t.integer :category
      t.decimal :price, precision: 10, scale: 2
      t.string :photo_url

      t.timestamps
    end
  end
end
