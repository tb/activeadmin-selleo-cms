ActiveAdmin.register ActiveadminSelleoCms::Locale, { as: "Locale", sort_order: 'name_asc' } do
  config.batch_actions = false

  actions :index, :update

  scope :enabled, default: true
  scope :popular
  scope :all

  index do
    column :name
    column :code
    column :enabled do |locale|
      check_box_tag "activeadmin_selleo_cms_locale[enabled][#{locale.code}]", 1, locale.enabled, data: { route: admin_locale_path(locale), id: locale.id, resource: 'locale', attribute: 'enabled' }
    end
  end

  controller do
    respond_to :html, :js
  end
end
