module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    include ContentTranslation

    translates :title, :slug, :browser_title, :meta_keywords, :meta_description

    acts_as_nested_set

    attr_protected :id

    attr_accessor :published, :is_link_url

    has_many :sections, as: :sectionable

    accepts_nested_attributes_for :translations, :sections, :children

    validates_format_of :link_url, with: /^http/i, allow_blank: true

    scope :show_in_menu, where(show_in_menu: true)
    scope :published, where("published_at IS NOT NULL")
    scope :not_published, where("published_at IS NULL")
    scope :latest, ->(n) { published.reorder("published_at DESC").limit(n) }
    scope :most_read, ->(n) { published.reorder("views DESC").limit(n) }

    before_validation do
      self.slug = self.title.parameterize if title and slug.blank?
      self.layout = 'application' unless layout
    end

    before_save do
      if published.present?
        if published_at.blank? and published.to_s.to_boolean
          self.published_at = Time.now
        elsif published.present? and published_at.present? and !published.to_s.to_boolean
          self.published_at = nil
        end
      end
    end

    def initialize_missing_sections
      section_names.each do |section_name|
        sections.build(name: section_name) unless sections.detect{|section| section.name == section_name}
      end
    end

    def to_s
      title
    end

    def section_names
      begin
        File.open(Dir.glob("app/views/layouts/#{layout}.html*").first).read.scan(/yield\s*\:(\w+)/).flatten
      rescue
        []
      end
    end

    def to_param
      slug
    end

    def is_link_url
      link_url.present?
    end

    class Translation
      attr_protected :id

      validates_presence_of :title #, :slug, unless: proc{|t| t.locale == I18n.locale }
      validates_uniqueness_of :slug, scope: :locale #, unless: proc{|t| t.locale == I18n.locale }
      validates_format_of :slug, with: /^[a-z0-9\-_]+$/i #, unless: proc{|t| t.locale == I18n.locale }
    end
  end
end
