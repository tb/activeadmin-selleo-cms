require 'nokogiri'
module ActiveadminSelleoCms
  class Layout

    def initialize(path)
      @path = path
      @file = File.read(path)
      @doc = Nokogiri::HTML(@file)
    end

    def section_names
      @section_names ||= sections.map(&:name)
    end

    def sections
      @sections ||= @doc.css('section[name]').map do |node|
        Section.new(node)
      end
    end

    def find_section(name)
      sections.detect{|section| section.name == name}
    end

    class << self
      def find(name)
        begin
          Layout.new(Dir.glob(File.join(Rails.root, "app/views/layouts/#{name}.html.erb")).first)
        rescue
          nil
        end
      end

      def all
        Dir.glob(File.join(Rails.root, 'app/views/layouts/[a-z]*html.erb')).map{|l| l.split('/').last.split('.').first }
      end
    end

    class Section
      attr_accessor :name, :type, :toolbar, :width, :height, :resize_method, :cover_width, :cover_height, :cover_resize_method

      def initialize(node)
        @name = node.attributes["name"].content
        @type = node.attributes["data-type"] ? node.attributes["data-type"].content : 'ckeditor'
        @attachments =  node.attributes["data-attachments"] ? node.attributes["data-attachments"].content.eql?("true") : false
        @attachment =  node.attributes["data-attachment"] ? node.attributes["data-attachment"].content.eql?("true") : false
        @related =  node.attributes["data-related"] ? node.attributes["data-related"].content.eql?("true") : false
        @toolbar = node.attributes["data-toolbar"] ? node.attributes["data-toolbar"].content : 'Minimal'
        @width = node.attributes["data-width"] ? node.attributes["data-width"].content : 640
        @height = node.attributes["data-height"] ? node.attributes["data-height"].content : 480
        @resize_method = node.attributes["data-resize-method"] ? node.attributes["data-resize-method"].content : "#"
        @cover_width = node.attributes["data-cover-width"] ? node.attributes["data-cover-width"].content : 140
        @cover_height = node.attributes["data-cover-height"] ? node.attributes["data-cover-height"].content : 199
        @cover_resize_method = node.attributes["data-cover-resize-method"] ? node.attributes["data-cover-resize-method"].content : ">"
      end

      def text?
        ['ckeditor', 'text', 'string'].include? @type.downcase
      end

      def image?
        ['image'].include? @type.downcase
      end

      def images?
        ['images'].include? @type.downcase
      end

      def attachments?
        ['files'].include?(@type.downcase) or @attachments
      end

      def attachment?
        ['file'].include?(@type.downcase) or @attachment
      end

      def related?
        ['related'].include?(@type.downcase) or @related
      end

    end
  end
end
