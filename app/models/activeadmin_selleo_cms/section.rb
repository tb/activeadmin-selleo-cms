module ActiveadminSelleoCms
  class Section < ActiveRecord::Base
    include ContentTranslation

    translates :body, fallbacks_for_empty_translations: true

    attr_protected :id

    belongs_to :sectionable, polymorphic: true

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

    def image_url
      if translation and translation.image
        translation.image.url
      else
        'http://placehold.it/770x385'
      end
    end

    class Translation
      attr_protected :id

      has_many :attachments, as: :assetable
      has_one :image, as: :assetable

      accepts_nested_attributes_for :attachments, :image
    end
  end
end
