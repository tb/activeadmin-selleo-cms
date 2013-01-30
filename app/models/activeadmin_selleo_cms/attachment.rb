module ActiveadminSelleoCms
  class Attachment < ActiveadminSelleoCms::Asset
    has_attached_file :data,
                      :url  => "/system/cms/attachments/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/attachments/:id/:style_:basename.:extension"

    validates_attachment_size :data, :less_than => 10.megabytes
    validates_attachment_presence :data

    attr_protected :id
  end
end
