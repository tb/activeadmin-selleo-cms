class Translation < ActiveRecord::Base
  attr_protected :id

  serialize :value
  serialize :interpolations, Array

  validates :locale, presence: true
  validates :key, presence: true, uniqueness: { scope: :locale }

  scope :incomplete, where(value: nil)
  scope :cms, -> { where("key LIKE '%cms.%'") }
  scope :active_admin, -> { where("key LIKE '%active_admin.%'") }

  def method_missing(sym, *args)
    if ActiveadminSelleoCms::Locale.enabled.map(&:code).include?(sym)
      Translation.where(locale: sym, key: key).first || ""
    else
      super
    end
  end

  def to_s
    value.to_s
  end
end
