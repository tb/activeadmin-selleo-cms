module ActiveadminSelleoCms
  class PagePart < ActiveRecord::Base
    include ContentTranslation

    translates :body

    attr_protected :id

    belongs_to :page

    accepts_nested_attributes_for :translations

    validates_presence_of :name
    validates_uniqueness_of :name, scope: :page_id

    class Translation
      attr_protected :id
    end
  end
end
