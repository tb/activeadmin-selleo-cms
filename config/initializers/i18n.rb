require "i18n/backend/fallbacks"
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

if ActiveRecord::Base.connection.table_exists? 'translations'
  require 'i18n/backend/active_record'
  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Fallbacks)
  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n.backend)
end