class CreateGenericIngredients < ActiveRecord::Migration
  def self.up
    create_table :generic_ingredients do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :generic_ingredients
  end
end
