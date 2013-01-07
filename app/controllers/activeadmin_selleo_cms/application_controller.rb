module ActiveadminSelleoCms
  class ApplicationController < ApplicationController

    before_filter do
      set_locale(params[:locale])
    end

    def set_locale(locale_code = :en)
      I18n.locale = locale_code
    end

  end
end
