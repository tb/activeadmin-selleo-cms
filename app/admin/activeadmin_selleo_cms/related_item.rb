ActiveAdmin.register ActiveadminSelleoCms::RelatedItem, { as: 'RelatedItem' } do
  config.batch_actions = false
  menu false

  controller do
    respond_to :html, :js
  end

  end
