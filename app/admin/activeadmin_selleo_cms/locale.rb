ActiveAdmin.register ActiveadminSelleoCms::Locale, { as: "Locale", sort_order: 'name_asc' } do
  actions :all, except: [:show, :destroy]

  index do
    column :name
    column :code
    column :enabled do |locale|
      check_box_tag "activeadmin_selleo_cms_locale[enabled][#{locale.code}]", 1, locale.enabled, data: { route: admin_locale_path(locale), id: locale.id }
    end
    render partial: 'js'
  end

  member_action :update, method: :put do
    @locale = ActiveadminSelleoCms::Locale.find_by_id(params[:id])
  end

end
