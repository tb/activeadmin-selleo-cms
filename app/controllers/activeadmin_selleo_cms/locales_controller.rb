module ActiveadminSelleoCms
  class LocalesController < ActiveadminSelleoCms::ApplicationController
    def change
      I18n.locale = params[:locale]
      redirect_to root_url
    end
  end
end
