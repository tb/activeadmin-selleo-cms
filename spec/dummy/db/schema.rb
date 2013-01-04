# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130103215146) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activeadmin_selleo_cms_assets", :force => true do |t|
    t.string   "data_file_name",    :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "type"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "activeadmin_selleo_cms_assets", ["assetable_type", "assetable_id"], :name => "idx_activeadmin_selleo_cms_assets_assetable"
  add_index "activeadmin_selleo_cms_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_activeadmin_selleo_cms_asset_assetable_type"

  create_table "activeadmin_selleo_cms_locales", :force => true do |t|
    t.string  "name"
    t.string  "code"
    t.boolean "enabled", :default => false
  end

  add_index "activeadmin_selleo_cms_locales", ["code"], :name => "index_activeadmin_selleo_cms_locales_on_code"
  add_index "activeadmin_selleo_cms_locales", ["enabled"], :name => "index_activeadmin_selleo_cms_locales_on_enabled"
  add_index "activeadmin_selleo_cms_locales", ["name"], :name => "index_activeadmin_selleo_cms_locales_on_name"

  create_table "activeadmin_selleo_cms_page_translations", :force => true do |t|
    t.integer  "activeadmin_selleo_cms_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "slug"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "activeadmin_selleo_cms_page_translations", ["activeadmin_selleo_cms_page_id"], :name => "index_85811c69f017d01e8cddfed40dfbdeb39c26bc44"
  add_index "activeadmin_selleo_cms_page_translations", ["locale"], :name => "index_activeadmin_selleo_cms_page_translations_on_locale"

  create_table "activeadmin_selleo_cms_pages", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "layout"
    t.boolean  "show_in_menu", :default => true
    t.boolean  "is_published"
    t.datetime "published_at"
    t.boolean  "is_link_url",  :default => false
    t.string   "link_url"
    t.integer  "views",        :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "activeadmin_selleo_cms_section_translations", :force => true do |t|
    t.integer  "activeadmin_selleo_cms_section_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "activeadmin_selleo_cms_section_translations", ["activeadmin_selleo_cms_section_id"], :name => "index_4a332b7c0d5c2103a6e9c871aaa818e8eb259dc6"
  add_index "activeadmin_selleo_cms_section_translations", ["locale"], :name => "index_activeadmin_selleo_cms_section_translations_on_locale"

  create_table "activeadmin_selleo_cms_sections", :force => true do |t|
    t.string   "name",             :null => false
    t.integer  "sectionable_id"
    t.string   "sectionable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "activeadmin_selleo_cms_sections", ["name"], :name => "index_activeadmin_selleo_cms_sections_on_name"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
