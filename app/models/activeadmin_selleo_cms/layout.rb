module ActiveadminSelleoCms
  class Layout < ActiveRecord::Base
    translates :template

    attr_protected :id

    has_many :pages

    accepts_nested_attributes_for :translations

    validates_presence_of :template, :name

    def initialize_missing_translations
      Locale.available_locale_codes.each do |locale_code|
        translations.build(locale: locale_code) unless translations.detect{|t| t.locale == locale_code}
      end
    end

    def to_s
      name
    end

    def part_names
      ::Liquid::Template.parse(template).root.nodelist.
          select{|node| node.is_a?(::Liquid::Variable) and node.name.match(/\w+_part/)}.map(&:name)
    end

    class Translation
      attr_protected :id
    end
  end
end
