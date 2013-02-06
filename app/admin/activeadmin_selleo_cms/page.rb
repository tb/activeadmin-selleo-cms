ActiveAdmin.register ActiveadminSelleoCms::Page, as: "Page", sort_order: "lft_asc" do
  config.batch_actions = false
  #config.paginate = false
  config.clear_action_items!

  actions :all

  form :partial => "form"

  filter :translations_title, as: :string
  filter :parent

  scope :roots
  scope :all, default: true

  index do
    column :title do |page|
      link_to page.breadcrumb, (page.children.any? ? (admin_pages_path(q: { parent_id_eq: page.id }, scope: :all)) : edit_admin_page_path( page.id ))
    end
    column :show_in_menu do |page|
      check_box_tag "activeadmin_selleo_cms_page[show_in_menu][#{page.id}]", 1, page.show_in_menu, data: { route: admin_page_path(page.id), id: page.id, resource: 'page', attribute: 'show_in_menu' }
    end
    column :is_published do |page|
      check_box_tag "activeadmin_selleo_cms_page[is_published][#{page.id}]", 1, page.is_published, data: { route: admin_page_path(page.id), id: page.id, resource: 'page', attribute: 'is_published' }
    end
    column :created_at do |page|
      l page.created_at, format: :short
    end
    column :updated_at do |page|
      l page.updated_at, format: :short
    end
    column :actions do |resource|
      links ||= link_to(I18n.t('active_admin.cms.view_on_site'), resource.url, :class => "member_link view_link", :target => "_new")
      links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource.id), :class => "member_link edit_link")
      links << link_to(I18n.t('active_admin.delete'), resource_path(resource.id), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
    end
  end

  show do
    h2 page.title
    attributes_table do
      row :parent do
        page.parent ? link_to(page.parent.title, page.parent.url) : nil
      end
      row :layout_name
      row :is_published
      row :show_in_menu
      row :is_link_url do
        (page.is_link_url ? page.link_url : false)
      end
      row :views
    end
  end

  action_item only:[:show] do
    link_to "Edit Page", edit_admin_page_path(page.id)
  end

  action_item only:[:index] do
    link_to "New Page", new_admin_page_path
  end

  action_item only:[:show,:edit] do
    link_to "View on site", page.url, target: '_blank'
  end

  action_item only:[:show,:edit] do
    link_to "Delete Page", admin_page_path(page.id), method: 'DELETE', confirm: 'Are you sure?'
  end

  collection_action :reorder, :method => :get do
    @pages = params[:parent_id] ? ActiveadminSelleoCms::Page.where(parent_id: params[:parent_id]) : ActiveadminSelleoCms::Page.roots
  end

  collection_action :update_positions, :method => :put do
  end

  controller do
    respond_to :html, :js

    def create
      @page = ActiveadminSelleoCms::Page.new(params[:page])
      if params[:_change_layout] == "1"
        render action: :new
      else
        create! do |success, failure|
          success.html { redirect_to admin_page_path(@page.id)  }
          failure.html { render action: :new  }
        end
      end
    end

    def update
      @page = ActiveadminSelleoCms::Page.find(params[:id])
      if params[:_change_layout] == "1"
        @page.attributes = params[:page]
        render action: :edit
      else
        update! do |success, failure|
          success.html { redirect_to admin_page_path(@page.id)  }
          failure.html { render action: :edit  }
        end
      end
    end
  end

end
