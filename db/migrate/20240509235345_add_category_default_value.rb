class AddCategoryDefaultValue < ActiveRecord::Migration[7.1]
  def up
    change_column :watches, :category, :integer
    change_column :watches, :price, :decimal, :precision  => 10, :scale => 2, default: 0
  end

  def down 
    change_column :watches, :category, :decimal, :precision  => 10, :scale => 2, default: 0
    change_column :watches, :price, :decimal, :precision  => 10, :scale => 2
  end
end
