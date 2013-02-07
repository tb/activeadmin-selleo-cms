module ActiveadminSelleoCms
  class Image < ActiveadminSelleoCms::Asset
    attr_accessor :image_width, :image_height, :resize_method

    has_attached_file :data,
                      :url  => "/system/cms/images/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/images/:id/:style_:basename.:extension",
                      :styles => Proc.new{ |attachment| attachment.instance.image_sizes },
                      :default_style => :normal

    validates_attachment_size :data, :less_than => 1.megabytes
    validates_attachment_presence :data

    attr_protected :id

    def image_sizes
      { :normal => "#{image_width || 640}x#{image_height || 480}#{resize_method || "#"}" }
    end

  end
end
