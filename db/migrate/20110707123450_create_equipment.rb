class CreateEquipment < ActiveRecord::Migration
  def self.up
    create_table :vessels do |t|
      t.column "full_capacity", :decimal, :precision => 10, :scale => 4
      t.column "target_capacity", :decimal, :precision => 10, :scale => 4
      t.column "empty_capacity", :decimal, :precision => 10, :scale => 4
      t.string "Name"
      t.string "Location"
      t.timestamps
    end 
    
   create_table :valves do |t|
      t.column "max_flow_rate", :decimal, :precision => 10, :scale => 4
      t.column "target_capacity", :decimal, :precision => 10, :scale => 4
      t.column "empty_capacity", :decimal, :precision => 10, :scale => 4
      t.string "Name"
      t.string "Location"
      t.timestamps
   end
   
   create_table :temperature_sensors do |t|
      t.string "probe_id"
      t.string "probe_type"
      t.column "max_temperature", :decimal, :precision => 10, :scale => 4
      t.column "min_temperature", :decimal, :precision => 10, :scale => 4
      t.string "Name"
      t.string "Location"
      t.timestamps
   end
   
   create_table :equipment do |t|
      t.string "Name"
      t.string "Location"
      t.timestamps
   end
   
   create_table :vessel_map do |t|
     t.integer "equipment_id"
     t.integer "vessel_id"
   end
   
   create_table :temperature_sensor_map do |t|
     t.integer "equipment_id"
     t.integer "temperature_sensor_id"
   end
   
   create_table :valve_map do |t|
     t.integer "equipment_id"
     t.integer "valve_id"
   end
   
    
    
  end

  def self.down
    drop_table :vessels
    drop_table :valves
    drop_table :temperature_sensors
    drop_table :equipment
    drop_table :vessel_map
    drop_table :temperature_sensor_map
    drop_table :valve_map
  end
end
