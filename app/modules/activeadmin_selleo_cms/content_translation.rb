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

  end
end
