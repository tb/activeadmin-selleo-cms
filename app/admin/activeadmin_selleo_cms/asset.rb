ActiveAdmin.register ActiveadminSelleoCms::Asset, { as: 'Asset' } do
  config.batch_actions = false

  belongs_to :page

  controller do
    respond_to :html, :js

    def destroy
      @page = ActiveadminSelleoCms::Page.find(params[:page_id])
      super do |format|
        format.js { render nothing: true }
      end
    end
  end

  end
