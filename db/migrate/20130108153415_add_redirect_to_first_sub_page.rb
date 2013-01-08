class AddRedirectToFirstSubPage < ActiveRecord::Migration
  def self.up
    add_column :activeadmin_selleo_cms_pages, :redirect_to_first_sub_page, :boolean, default: false
    execute "UPDATE activeadmin_selleo_cms_pages SET redirect_to_first_sub_page = false"
  end

  def self.down
    remove_column :activeadmin_selleo_cms_pages, :redirect_to_first_sub_page
  end
end
