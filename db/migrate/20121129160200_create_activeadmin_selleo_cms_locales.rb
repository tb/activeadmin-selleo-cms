class CreateActiveadminSelleoCmsLocales < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_locales do |t|
      t.string :name
      t.string :code
      t.boolean :enabled, default: false
    end
    add_index :activeadmin_selleo_cms_locales, :name
    add_index :activeadmin_selleo_cms_locales, :code
    add_index :activeadmin_selleo_cms_locales, :enabled
  end
end
