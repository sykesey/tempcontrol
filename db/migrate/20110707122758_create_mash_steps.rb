class CreateMashSteps < ActiveRecord::Migration
  def self.up
    create_table :mash_steps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mash_steps
  end
end
