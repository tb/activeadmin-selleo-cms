class CreateActiveadminSelleoCmsPages < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_pages do |t|
      t.string :title
      t.string :browser_title
      t.string :meta_keywords
      t.text :meta_description
      t.timestamps
    end
    ActiveadminSelleoCms::Page.create_translation_table! title: :string, browser_title: :string, meta_keywords: :string, meta_description: :text
  end
end
