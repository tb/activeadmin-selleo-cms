ActiveAdmin.register ActiveadminSelleoCms::Section, as: "Section", sort_order: "name_asc" do
  config.batch_actions = false
  config.paginate = true

  form :partial => "form"

  scope :blurbs, default: true
  scope :help

  index do
    column :name
    column :created_at do |page|
      l page.created_at, format: :short
    end
    column :updated_at do |page|
      l page.updated_at, format: :short
    end
    column :actions do |resource|
      links ||= link_to(I18n.t('active_admin.edit'), edit_resource_path(resource.id), :class => "member_link edit_link")
    end
  end

  controller do
    respond_to :html, :js

    def create
      create! do |success, failure|
        success.html { redirect_to admin_sections_path  }
        failure.html { render action: :new  }
      end
    end

    def update
      update! do |success, failure|
        success.html { redirect_to admin_sections_path  }
        failure.html { render action: :edit  }
      end
    end

  end

end
