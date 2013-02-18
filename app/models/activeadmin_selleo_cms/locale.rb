module ActiveadminSelleoCms
  class Locale < ActiveRecord::Base
    attr_protected :id

    validates :name, presence: true
    validates :code, presence: true, uniqueness: true

    scope :enabled, where(enabled: true)
    scope :available_locales, enabled
    scope :exclude, ->(codes){ where("code NOT IN (?)", Array(codes)) }

    scope :popular, where(code: %w(da de el en es fr hu it lt lv nl no pl pt ru sk sl sv))

    def to_s
      code
    end

    def code
      read_attribute(:code).to_sym
    end

    def url
      "/#{to_s}"
    end

    class << self
      def except(locale_codes)
        locale_codes = [locale_codes] unless locale_codes.is_a? Array
        enabled.where("code NOT IN (?)", locale_codes).map(&:code)
      end

      def available_locale_codes
        enabled.map(&:to_s)
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
