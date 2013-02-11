module ActiveadminSelleoCms
  class RelatedItem < ActiveRecord::Base
    attr_protected :id

    belongs_to :relatable, polymorphic: true
    belongs_to :related, polymorphic: true

    validates_presence_of :relatable
    validates_presence_of :related, if: ->(ri){ ri.related_url.blank? }
    validates :related_url, presence: true, format: { with: /^http/i }, if: ->(ri){ ri.related.blank? }

    def target_title
      title.present? ? title : (related.present? ? related.title : related_url)
    end

    def target_url
      related_url.present? ? related_url : related.url
    end

  end
end
