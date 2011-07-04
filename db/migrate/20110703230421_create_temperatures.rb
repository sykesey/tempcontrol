class CreateTemperatures < ActiveRecord::Migration
  def self.up
    create_table :temperatures do |t|
      t.column "id", :integer, :primary_key => true
      t.string :probe_name
      t.string :probe_id
      t.column "value", :decimal, :precision => 10, :scale => 4
      t.timestamps
    end
  end

  def self.down
    drop_table :temperatures
  end
end
