class CreateMashProfiles < ActiveRecord::Migration
  def self.up
    create_table :mash_profiles do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mash_profiles
  end
end
