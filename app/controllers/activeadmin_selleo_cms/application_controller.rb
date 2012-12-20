module ActiveadminSelleoCms
  class ApplicationController < ActionController::Base

    before_filter do
      I18n.locale = params[:locale]
    end

  end
end
