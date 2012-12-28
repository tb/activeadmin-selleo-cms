class CreateActiveadminSelleoCmsPages < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_pages do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :layout
      t.boolean :show_in_menu, default: true
      t.boolean :is_published
      t.datetime :published_at
      t.boolean :is_link_url, default: false
      t.string :link_url
      t.integer :views, default: 0
      t.timestamps
    end

    ActiveadminSelleoCms::Page.create_translation_table! title: :string, slug: :string, browser_title: :string, meta_keywords: :string, meta_description: :text
  end
end
