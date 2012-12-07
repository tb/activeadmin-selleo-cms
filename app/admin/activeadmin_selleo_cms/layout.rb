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

end
