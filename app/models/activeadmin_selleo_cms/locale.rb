module ActiveadminSelleoCms
  class Locale < ActiveRecord::Base
    attr_accessible :code, :enabled, :name, as: :admin

    validates :name, presence: true
    validates :code, presence: true, uniqueness: true

    scope :enabled, where(:enabled => true)
    scope :available_locales, enabled

    def to_s
      code
    end

    def code
      read_attribute(:code).to_sym
    end

    def url
      "/#{code}"
    end

    class << self
      def except(sym)
        enabled.map(&code).reject(sym)
      end

      def available_locale_codes
        available_locales.map(&:to_s)
      end

      def method_missing(sym, *args)
        if sym.to_s =~ /^[a-z]{2}$/
          Locale.where(code: sym).first
        else
          super
        end
      end
    end

  end
end
