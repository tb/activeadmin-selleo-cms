module ActiveAdmin
  module Views

    class IndexAsList < ActiveAdmin::Component

      def build(page_presenter, collection)
        add_class "index"
        collection.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end

      def render_tree(obj)
        ol class: ('sortable' if obj.level == 0) do
          li do
            div do
              obj.to_s
            end
            obj.children.each{|c| render_tree(c)} if obj.children.any?
          end
        end
        render partial: 'js'
      end

    end
  end
end

