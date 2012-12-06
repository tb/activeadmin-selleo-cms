module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    translates :title, :slug, :browser_title, :meta_keywords, :meta_description

    attr_protected :id

    accepts_nested_attributes_for :translations

    validates_presence_of :title, :slug
    validates_uniqueness_of :slug
    validates_format_of :slug, with: /^[a-z0-9\-_]+$/i

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    class Translation
      attr_protected :id

      validates_presence_of :title, :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_uniqueness_of :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_format_of :slug, with: /^[a-z0-9\-_]+$/i, unless: proc{|t| t.locale == I18n.locale }
    end
  end
end
