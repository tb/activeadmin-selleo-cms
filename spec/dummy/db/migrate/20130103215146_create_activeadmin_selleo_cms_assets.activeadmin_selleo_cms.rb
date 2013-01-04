# This migration comes from activeadmin_selleo_cms (originally 20130102113712)
class CreateActiveadminSelleoCmsAssets < ActiveRecord::Migration
  def self.up
    create_table :activeadmin_selleo_cms_assets do |t|
      t.string  :data_file_name, :null => false
      t.string  :data_content_type
      t.integer :data_file_size
      
      t.integer :assetable_id
      t.string  :assetable_type
      t.string  :type

      t.integer :width
      t.integer :height

      t.timestamps
    end
    
    add_index "activeadmin_selleo_cms_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_activeadmin_selleo_cms_asset_assetable_type"
    add_index "activeadmin_selleo_cms_assets", ["assetable_type", "assetable_id"], :name => "idx_activeadmin_selleo_cms_assets_assetable"
  end

  def self.down
    drop_table :activeadmin_selleo_cms_assets
  end
end
