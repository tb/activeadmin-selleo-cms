require 'texticle/rails'
module ActiveadminSelleoCms
  class Layout
    class << self
      def all
        Dir.glob(File.join(Rails.root, 'app/views/layouts/[a-z]*html*')).map{|l| l.split('/').last.split('.').first }
      end
    end
  end
end
