class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :title
      t.text :quote
      t.string :by

      t.timestamps null: false
    end
  end
end
