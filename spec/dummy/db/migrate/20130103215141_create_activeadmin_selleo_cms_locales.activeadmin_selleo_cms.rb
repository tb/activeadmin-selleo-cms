# This migration comes from activeadmin_selleo_cms (originally 20121129160200)
class CreateActiveadminSelleoCmsLocales < ActiveRecord::Migration
  def up
    create_table :activeadmin_selleo_cms_locales do |t|
      t.string :name
      t.string :code
      t.boolean :enabled, default: false
    end
    add_index :activeadmin_selleo_cms_locales, :name
    add_index :activeadmin_selleo_cms_locales, :code
    add_index :activeadmin_selleo_cms_locales, :enabled
    LanguageList::COMMON_LANGUAGES.each do |lang|
      ActiveadminSelleoCms::Locale.create({name: lang.name, code: lang.iso_639_1, enabled: ['en'].include?(lang.iso_639_1)}, as: :admin)
    end
  end

  def down
    drop_table :activeadmin_selleo_cms_locales
  end
end
