module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    include ContentTranslation

    translates :title, :slug, :browser_title, :meta_keywords, :meta_description

    acts_as_nested_set

    attr_protected :id

    has_many :sections, as: :sectionable

    accepts_nested_attributes_for :translations, :sections, :children

    validates_format_of :link_url, with: /^http/i, allow_blank: false, if: ->(page) { page.is_link_url }

    scope :show_in_menu, where(show_in_menu: true)
    scope :published, where(is_published: true)
    scope :not_published, where(is_published: false)
    scope :latest, ->(n) { published.reorder("published_at DESC").limit(n) }
    scope :most_read, ->(n) { published.reorder("views DESC").limit(n) }

    before_validation do
      self.slug = self.title.parameterize if title and slug.blank?
      self.layout = 'application' unless layout
    end

    before_save do
      if is_published_changed?
        self.published_at = is_published ? Time.now : nil
      end
    end

    after_initialize do
      self.layout = Layout.all.first if new_record?
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

    class Translation
      attr_protected :id

      validates_presence_of :title
      validates_uniqueness_of :slug, scope: :locale #, unless: ->(translation) { translation.page.is_link_url }
      validates_format_of :slug, with: /^[a-z0-9\-_]+$/i #, unless: ->(translation) { translation.page.is_link_url }
    end
  end
end
