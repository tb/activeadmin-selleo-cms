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
      attr_accessor :name, :type, :toolbar

      def initialize(node)
        @name = node.attributes["name"].content
        @type = node.attributes["data-type"] ? node.attributes["data-type"].content : 'ckeditor'
        @attachments = (['files'].include?(@type) or node.attributes["attachments"]) ? true : false
        @toolbar = node.attributes["data-toolbar"] ? node.attributes["data-toolbar"].content : 'Minimal'
      end

      def text?
        ['ckeditor', 'text'].include? @type
      end

      def attachments?
        @attachments == true
      end

    end
  end
end
