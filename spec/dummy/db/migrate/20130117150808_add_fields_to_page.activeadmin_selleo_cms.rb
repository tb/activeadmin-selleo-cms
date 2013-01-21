# This migration comes from activeadmin_selleo_cms (originally 20130109132745)
class AddFieldsToPage < ActiveRecord::Migration
  def self.up
    add_column :activeadmin_selleo_cms_pages, :settings, :text
  end

  def self.down
    remove_column :activeadmin_selleo_cms_pages, :settings
  end
end
