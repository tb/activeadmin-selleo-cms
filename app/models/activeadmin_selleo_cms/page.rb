module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    include ContentTranslation

    translates :title, :slug, :browser_title, :meta_keywords, :meta_description

    acts_as_nested_set

    attr_protected :id

    has_many :page_parts

    accepts_nested_attributes_for :translations, :page_parts, :children

    validates_presence_of :title, :slug, :layout
    validates_uniqueness_of :slug
    validates_format_of :slug, with: /^[a-z0-9\-_]+$/i

    scope :show_in_menu, where(show_in_menu: true)

    before_validation do
      self.slug = self.title.parameterize if title and slug.blank?
      self.layout = 'application' unless layout
    end

    def initialize_missing_parts
      part_names.each do |part_name|
        page_parts.build(name: part_name) unless page_parts.detect{|pp| pp.name == part_name}
      end
    end

    def to_s
      title
    end

    def part_names
      File.open(Dir.glob("app/views/layouts/#{layout}.html*").first).read.scan(/yield\s*\:(\w+)/).flatten
    end

    def to_param
      slug
    end

    class Translation
      attr_protected :id

      validates_presence_of :title, :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_uniqueness_of :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_format_of :slug, with: /^[a-z0-9\-_]+$/i, unless: proc{|t| t.locale == I18n.locale }
    end
  end
end
