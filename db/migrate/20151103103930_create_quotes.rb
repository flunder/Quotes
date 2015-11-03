class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text   :quote
      t.string :by
    end
  end
end
