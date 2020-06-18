class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.string :category

      t.timestamps
    end
  end
end
