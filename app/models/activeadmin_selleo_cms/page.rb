module ActiveadminSelleoCms
  class Page < ActiveRecord::Base
    include ContentTranslation

    translates :title, :slug, :browser_title, :meta_keywords, :meta_description, fallbacks_for_empty_translations: true

    acts_as_nested_set

    attr_protected :id

    has_many :sections, as: :sectionable
    has_one :icon, as: :assetable
    has_one :header_image, as: :assetable
    has_many :attachments, as: :assetable
    has_many :assets, as: :assetable

    accepts_nested_attributes_for :translations, :sections, :children, :icon, :header_image, :attachments

    validates_format_of :link_url, with: /^http/i, allow_blank: false, if: ->(page) { page.is_link_url }
    validates_presence_of :layout
    validates_associated :translations, :sections

    scope :show_in_menu, where(show_in_menu: true)
    scope :published, where(is_published: true)
    scope :not_published, where(is_published: false)
    scope :latest, ->(n) { published.reorder("published_at DESC").limit(n) }
    scope :most_read, ->(n) { published.reorder("views DESC").limit(n) }

    before_validation do
      self.slug = self.title.parameterize if title and slug.blank?
    end

    before_save do
      if is_published_changed?
        self.published_at = is_published ? Time.now : nil
      end
    end

    after_initialize do
      self.layout = Layout.all.first if new_record? and layout.blank?
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
        File.open(Dir.glob(File.join(Rails.root, "app/views/layouts/#{layout}.html*")).first).read.scan(/yield\s*\:(\w+)/).flatten
      rescue
        []
      end
    end

    def to_param
      slug
    end

    def icon_url
      icon ? icon.url : 'http://placehold.it/120x90'
    end

    def header_image_url
      header_image ? header_image.url : 'http://placehold.it/770x385'
    end

    def roots
      Page.published.roots
    end

    def breadcrumb
      self_and_ancestors.map(&:title).join(' &raquo; ').html_safe
    end

    class Translation
      attr_protected :id

      validates :title, presence: true, if: ->(translation){ translation.locale.eql? I18n.locale }
      validates :slug, presence: true, uniqueness: { scope: :locale}, format: { with: /^[a-z0-9\-_]+$/i }, if: ->(translation) { translation.locale.eql? I18n.locale }
    end
  end
end
