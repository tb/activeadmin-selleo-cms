module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    translates :title, :slug, :browser_title, :meta_keywords, :meta_description

    acts_as_nested_set

    attr_protected :id

    has_many :page_parts
    belongs_to :layout

    accepts_nested_attributes_for :translations, :page_parts

    delegate :part_names, to: :layout

    validates_presence_of :title, :slug
    validates_uniqueness_of :slug
    validates_format_of :slug, with: /^[a-z0-9\-_]+$/i

    after_initialize do
      self.layout = Layout.first unless layout
    end

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    def initialize_missing_parts
      part_names.each do |part_name|
        page_parts.build(name: part_name) unless page_parts.detect{|pp| pp.name == part_name}
      end
    end

    def to_s
      title
    end

    class Translation
      attr_protected :id

      validates_presence_of :title, :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_uniqueness_of :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_format_of :slug, with: /^[a-z0-9\-_]+$/i, unless: proc{|t| t.locale == I18n.locale }
    end
  end
end
