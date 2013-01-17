def set_admin_locale
  I18n.locale = :en
end

def determine_field_type(val)
  if [TrueClass, FalseClass].include? val.class
    :boolean
  else
    :string
  end
end