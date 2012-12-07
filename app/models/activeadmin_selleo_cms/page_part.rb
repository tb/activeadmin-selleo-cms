module ActiveadminSelleoCms
  class PagePart < ActiveRecord::Base
    translates :body

    attr_protected :id

    belongs_to :page

    accepts_nested_attributes_for :translations

    validates_presence_of :name
    validates_uniqueness_of :name, scope: :page_id

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    class Translation
      attr_protected :id
    end
  end
end
