ActiveAdmin.register ActiveadminSelleoCms::Page, as: "Page", sort_order: "lft_asc" do
  config.batch_actions = false

  scope :all, default: true

  -> {
    ActiveadminSelleoCms::Page.roots.each do |page|
      scope page.title do
        ActiveadminSelleoCms::Page.where(parent_id: page.id)
      end
    end
  }

  form :partial => "form"

  filter :parent

  index do
    column :title do |page|
      "#{'&#8212;' * page.depth}  #{page.title}".html_safe
    end
    column :show_in_menu do |page|
      check_box_tag "activeadmin_selleo_cms_page[show_in_menu][#{page.id}]", 1, page.show_in_menu, data: { route: admin_page_path(page.id), id: page.id, resource: 'page', attribute: 'show_in_menu' }
    end
    column :is_published do |page|
      check_box_tag "activeadmin_selleo_cms_page[is_published][#{page.id}]", 1, page.is_published, data: { route: admin_page_path(page.id), id: page.id, resource: 'page', attribute: 'is_published' }
    end
    column :created_at
    column :updated_at
    column :actions do |resource|
      links ||= link_to(I18n.t('active_admin.view'), "/#{I18n.locale}/#{resource.slug}", :class => "member_link view_link", :target => "_new")
      links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource.id), :class => "member_link edit_link")
      links << link_to(I18n.t('active_admin.delete'), resource_path(resource.id), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
    end
  end

  #index as: :list, download_links: false do |page|
  #  render_tree(page)
  #end

  controller do
    respond_to :html, :js

    def create
      @page = ActiveadminSelleoCms::Page.new(params[:page])
      if params[:_change_layout] == "1"
        render action: :new
      else
        create! do |success, failure|
          success.html { render action: :index  }
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
          success.html { render action: :index  }
          failure.html { render action: :edit  }
        end
      end
    end
  end

end
