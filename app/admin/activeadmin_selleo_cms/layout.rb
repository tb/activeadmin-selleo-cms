ActiveAdmin.register ActiveadminSelleoCms::Layout, as: "Layout" do

  index do
    column :id
    column :name
    column :pages do |layout|
      layout.pages.count
    end
    column :created_at
    column :updated_at
    default_actions
  end

  controller do
    def create
      create! do |success, failure|
        success.html { redirect_to admin_layouts_path }
        failure.html { render action: :new  }
      end
    end

    def update
      update! do |success, failure|
        success.html { redirect_to admin_layouts_path }
        failure.html { render action: :edit  }
      end
    end
  end

end
