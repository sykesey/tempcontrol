class CreateTemperatures < ActiveRecord::Migration
  def self.up
    create_table :temperatures do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :temperatures
  end
end
