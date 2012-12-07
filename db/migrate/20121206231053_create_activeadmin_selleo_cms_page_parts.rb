class CreateActiveadminSelleoCmsPageParts < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_page_parts do |t|
      t.string :name, :null => false
      t.string :body
      t.belongs_to :page
      t.timestamps
    end
    ActiveadminSelleoCms::PagePart.create_translation_table! body: :text
  end
end
