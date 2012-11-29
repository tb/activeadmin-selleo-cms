class CreateActiveadminSelleoCmsLocales < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_locales do |t|
      t.string :name
      t.string :code
      t.boolean :enabled, default: false
    end
    add_index :locales, :name
    add_index :locales, :code
    add_index :locales, :enabled
  end
end
