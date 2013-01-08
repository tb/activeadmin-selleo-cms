FactoryGirl.define do
  factory :page, class: ActiveadminSelleoCms::Page do
    title         "Sample page"
    is_published  true
    show_in_menu  true
    layout        "cms"
  end
end
