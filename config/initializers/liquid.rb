module Liquid
  class Menu < Tag
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include ActionView::Context

    def initialize(tag_name, markup, tokens)
      @options = variables_from_string(markup)
      @menu_items = if @options["root"] and @root = ActiveadminSelleoCms::Page.find_by_id(@options["root"])
        @root.children
      else
        ActiveadminSelleoCms::Page.roots
      end

      super
    end

    def render(context)
      content_tag :ul, class: @options["ul_classes"] do
        @menu_items.each do |menu_item|
          content_tag :li, class: @options["li_classes"] do
            link_to menu_item.title, menu_item.slug
          end
        end
      end
    end

    private

    def variables_from_string(markup)
      variables = markup.split(',').collect do |var|
        var =~ /\s*(\w+)\s*:\s*(.+)\s*/o
        $1 ? [$1, $2] : nil
      end.compact
      Hash[variables]
    end
  end

  Template.register_tag('menu', Menu)
end
