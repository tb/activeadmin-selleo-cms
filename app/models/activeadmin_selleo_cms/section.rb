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

    class Translation
      attr_protected :id

      has_many :attachments, as: :assetable

      accepts_nested_attributes_for :attachments
    end
  end
end
