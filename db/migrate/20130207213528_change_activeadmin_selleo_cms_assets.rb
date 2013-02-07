class ChangeActiveadminSelleoCmsAssets < ActiveRecord::Migration
  def up
    add_column :activeadmin_selleo_cms_assets, :cover_file_name, :string
    add_column :activeadmin_selleo_cms_assets, :cover_content_type, :string
    add_column :activeadmin_selleo_cms_assets, :cover_file_size, :integer

    add_column :activeadmin_selleo_cms_assets, :caption, :string
  end

  def down
  end
end
