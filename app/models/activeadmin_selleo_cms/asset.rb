module ActiveadminSelleoCms
  class Asset < ActiveRecord::Base
    attr_protected :id
    attr_accessor :cover_width, :cover_height, :cover_resize_method

    belongs_to :assetable, polymorphic: true

    has_attached_file :cover,
                      :url  => "/system/cms/covers/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/covers/:id/:style_:basename.:extension",
                      :styles => Proc.new{ |attachment| attachment.instance.image_sizes },
                      :default_style => :normal

    validates_attachment_size :cover, :less_than => 10.megabytes

    def url(format=nil)
      data.url(format)
    end

    def image_sizes
      { :normal => "#{cover_width || 120}x#{cover_height || 90}#{cover_resize_method || ">"}" }
    end

  end
end
