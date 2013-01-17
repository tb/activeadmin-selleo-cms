class LocalesController < ApplicationController
  def show
    I18n.locale = session[:locale_code] = params[:id]
    redirect_to root_url
  end
end
