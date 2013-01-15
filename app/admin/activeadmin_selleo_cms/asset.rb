ActiveAdmin.register ActiveadminSelleoCms::Asset, { as: 'Asset' } do
  config.batch_actions = false

  #belongs_to :page

  controller do
    respond_to :html, :js
  end

  end
