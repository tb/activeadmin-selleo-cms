module ActiveadminSelleoCms
  class Section < ActiveRecord::Base
    include ContentTranslation

    translates :body

    attr_protected :id

    belongs_to :sectionable, polymorphic: true

    accepts_nested_attributes_for :translations

    validates_presence_of :name
    validates_uniqueness_of :name, scope: [:sectionable_type, :sectionable_id]

    class Translation
      attr_protected :id
    end
  end
end
