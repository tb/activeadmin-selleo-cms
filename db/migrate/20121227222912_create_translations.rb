class CreateTranslations < ActiveRecord::Migration
  def up
    create_table :translations do |t|
      t.string :locale
      t.string :key
      t.text :value
      t.text :interpolations
      t.boolean :is_proc, default: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps
    end
  end

  def down
    drop_table :translations
  end
end
