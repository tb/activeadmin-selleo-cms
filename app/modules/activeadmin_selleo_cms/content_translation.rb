module ActiveadminSelleoCms
  module ContentTranslation

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
    end

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    def create_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.create(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    def translated_attribute(attr, locale)
      _locale = I18n.locale
      I18n.locale = locale
      translation = send(attr.to_sym)
      I18n.locale = _locale
      translation
    end

  end
end
