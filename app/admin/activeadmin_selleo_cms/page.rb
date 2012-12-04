ActiveAdmin.register ActiveadminSelleoCms::Page, as: "Page" do
  form :partial => "form"

  index do
    column :id
    column :title
    column :actions do |resource|
      links ||= link_to(I18n.t('active_admin.view'), "/#{resource.slug}", :class => "member_link view_link", :target => "_new")
      links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
      links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
    end
  end
end
