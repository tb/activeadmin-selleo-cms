class AddFieldsToPage < ActiveRecord::Migration
  def self.up
    add_column :activeadmin_selleo_cms_pages, :settings, :text
  end

  def self.down
    remove_column :activeadmin_selleo_cms_pages, :settings
  end
end
