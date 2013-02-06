require 'texticle/rails'
module ActiveadminSelleoCms
  class Search < ActiveRecord::Base
    extend Texticle

    belongs_to :searchable, polymorphic: true

    scope :current_locale, -> { where(locale: I18n.locale) }
    scope :published, -> { where(is_published: true) }
  end
end
