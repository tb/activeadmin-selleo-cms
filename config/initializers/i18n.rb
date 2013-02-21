I18n.default_locale = :en

require "i18n/backend/fallbacks"
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

if ActiveRecord::Base.connection.table_exists?('translations') and !Rails.env.development?
  require 'i18n/backend/active_record'
  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Fallbacks)
  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n.backend)
end

module I18n
  module Backend
    class ActiveRecord

      module Implementation

        def store_translations(locale, data, options = {})
          escape = options.fetch(:escape, true)
          flatten_translations(locale, data, escape, false).each do |key, value|
            unless Translation.locale(locale).lookup(key).any?
              Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value)
            end
          end
        end

      end

    end
  end
end
