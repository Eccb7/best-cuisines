# frozen_string_literal: true

class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.text :name
      t.integer :measurement_unit
      t.float :price
      t.integer :quantity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
