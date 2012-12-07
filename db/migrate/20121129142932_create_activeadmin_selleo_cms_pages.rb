class CreateActiveadminSelleoCmsPages < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_pages do |t|
      t.string :title, :null => false
      t.string :slug, :null => false
      t.string :browser_title
      t.string :meta_keywords
      t.text :meta_description
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.timestamps
    end
    ActiveadminSelleoCms::Page.create_translation_table! title: :string, slug: :string, browser_title: :string, meta_keywords: :string, meta_description: :text
  end
end
