module ActiveadminSelleoCms
  class Asset < ActiveRecord::Base
    attr_protected :id

    belongs_to :assetable, polymorphic: true

    def url(format=nil)
      data.url(format)
    end
  end
end
