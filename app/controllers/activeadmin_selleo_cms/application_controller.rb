module ActiveadminSelleoCms
  class ApplicationController < ApplicationController

    before_filter do
      I18n.locale = params[:locale]
    end

  end
end
