module ActiveadminSelleoCms
  class Asset < ActiveRecord::Base
    attr_protected :id

    belongs_to :assetable, polymorphic: true

    has_attached_file :cover,
                      :url  => "/system/cms/covers/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/covers/:id/:style_:basename.:extension"

    validates_attachment_size :cover, :less_than => 10.megabytes

    def url(format=nil)
      data.url(format)
    end
  end
end
