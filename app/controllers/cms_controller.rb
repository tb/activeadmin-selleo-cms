class CmsController < ApplicationController

  before_filter do
    set_locale(params[:locale])
    @available_locales = ActiveadminSelleoCms::Locale.enabled
  end

  def set_locale(locale_code = :en)
    I18n.locale = locale_code
  end

end
