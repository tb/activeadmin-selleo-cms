ActiveAdmin.register Translation do
  config.batch_actions = false

  actions :index

  scope :cms, default: true
  scope :active_admin
  scope :all

  index do
    column :key
    -> { ActiveadminSelleoCms::Locale.enabled }.call.each do |locale|
      column locale.name do |translation|
        content_tag :div, class: "translation" do
          text_field_tag "#{locale.code}[#{translation.key}]", translation.send(locale.code), data: { locale: locale.code, key: translation.key, route: admin_translations_path }
        end
      end
    end
  end

  filter :key
  filter :value

  collection_action :update, method: :put do
    unless @translation = Translation.where(key: params[:key], locale: params[:locale]).first
      @translation = Translation.create({key: params[:key], locale: params[:locale]}, as: :admin)
    end
  end

  controller do
    def collection
      (get_collection_ivar || set_collection_ivar(active_admin_collection)).reorder(:key).select("DISTINCT(key)")
    end
  end
end
