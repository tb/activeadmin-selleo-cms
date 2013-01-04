FactoryGirl.define do
  factory :locale, class: ActiveadminSelleoCms::Locale do
    name    "English"
    code    "en"
    enabled true
  end
end
