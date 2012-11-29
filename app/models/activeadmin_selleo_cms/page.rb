module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    translates :title, :browser_title, :meta_keywords, :meta_description

    attr_protected :id

    accepts_nested_attributes_for :translations

    validates_presence_of :title

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.find_by_locale(locale_code)
      end
    end

    class Translation
      attr_protected :id
    end
  end
end
