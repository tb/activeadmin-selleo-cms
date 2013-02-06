module ActiveadminSelleoCms
  class Section < ActiveRecord::Base
    include ContentTranslation

    translates :body, fallbacks_for_empty_translations: true

    attr_protected :id

    belongs_to :sectionable, polymorphic: true

    delegate :layout, to: :sectionable

    accepts_nested_attributes_for :translations

    validates_presence_of :name
    validates_uniqueness_of :name, scope: [:sectionable_type, :sectionable_id]
    validates_associated :translations

    scope :with_name, ->(section_name) { where(name: section_name) }
    scope :blurbs, where("name ILIKE 'blurb.%'")
    scope :help, where("name ILIKE 'help.%'")

    def toolbar
      case name
        when /blurb\./ then "Easy"
        when /help\./ then "Lite"
        else "Easy"
      end
    end

    def image
      if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.image}
        current_translation.image
      else
        nil
      end
    end

    def images
      if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.images.any? }
        current_translation.images
      else
        []
      end
    end

    class Translation
      attr_protected :id

      has_many :attachments, as: :assetable
      has_many :images, as: :assetable
      has_one :image, as: :assetable

      accepts_nested_attributes_for :attachments
      accepts_nested_attributes_for :image, reject_if: lambda{ |i| i[:data].blank? }
      accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:data].blank? }
    end
  end
end
