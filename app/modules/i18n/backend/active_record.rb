require 'i18n/backend/base'
require 'i18n/backend/active_record/translation'

module I18n
  module Backend
    class ActiveRecord

      module Implementation
        include Base, Flatten

        def store_translations(locale, data, options = {})
          escape = options.fetch(:escape, true)
          flatten_translations(locale, data, escape, false).each do |key, value|
            unless Translation.locale(locale).lookup(key).any?
              Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value)
            end
          end
        end

      end

      include Implementation
    end
  end
end
