module ActiveadminSelleoCms
  class Asset < ActiveRecord::Base
    attr_accessible :data

    belongs_to :assetable, polymorphic: true

    def url(format=nil)
      data.url(format)
    end
  end
end
