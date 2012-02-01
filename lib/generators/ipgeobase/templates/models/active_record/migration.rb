class CreateTablesForIpgeobase < ActiveRecord::Migration
  def self.up
    create_table :ipgeobase_ips, :id => false do |t|
      t.integer :start_ip, :limit => 8
      t.integer :end_ip, :limit => 8
      t.integer :ipgeobase_region_id
    end

    add_index :ipgeobase_ips, [:start_ip]
    add_index :ipgeobase_ips, [:ipgeobase_region_id], :name => "index_ipgeobase_ips_on_ipgeobase_region_id"

    create_table :ipgeobase_regions do |t|
      t.string :name
      t.string :ancestry
      t.text   :names_depth_cache
      t.timestamps
    end

    add_index :ipgeobase_regions, :ancestry

  end

  def self.down
    drop_table :ipgeobase_regions
    drop_table :ipgeobase_ips
  end
end
