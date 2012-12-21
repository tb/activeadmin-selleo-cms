ActiveAdmin.register ActiveadminSelleoCms::Page, as: "Page", sort_order: "lft_asc" do
  config.batch_actions = false

  scope :all, default: true
  scope :published
  scope :not_published

  form :partial => "form"

  index do
    column do |resource|
      unless resource.root?
        "#{image_tag('http://placehold.it/20x15') * resource.depth}".html_safe
      end
    end
    column :title
    column :show_in_menu
    column :created_at
    column :updated_at
    column :published_at do |resource|
      resource.published_at
    end
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
    def index
      index! {
        #@pages = @pages.where(parent_id: nil)
      }
    end

    def create
      create! do |success, failure|
        success.html { redirect_to admin_pages_path }
        failure.html { render action: :new  }
      end
    end

    def update
      update! do |success, failure|
          success.html { redirect_to admin_pages_path }
          failure.html { render action: :edit  }
      end
    end
  end

end
