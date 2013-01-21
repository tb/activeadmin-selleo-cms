# This migration comes from activeadmin_selleo_cms (originally 20121206231053)
class CreateActiveadminSelleoCmsSections < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_sections do |t|
      t.string :name, :null => false
      t.belongs_to :sectionable, polymorphic: true
      t.timestamps
    end
    add_index :activeadmin_selleo_cms_sections, :name

    ActiveadminSelleoCms::Section.create_translation_table! body: :text
  end
end
