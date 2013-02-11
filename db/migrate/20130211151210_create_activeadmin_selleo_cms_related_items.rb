class CreateActiveadminSelleoCmsRelatedItems < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_related_items do |t|
      t.integer :relatable_id
      t.string  :relatable_type

      t.integer :related_id
      t.string  :related_type

      t.string  :related_url

      t.string  :title

      t.timestamps
    end
  end
end
