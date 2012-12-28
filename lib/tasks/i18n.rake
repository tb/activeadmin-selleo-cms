namespace :i18n do
  task(:load => :environment) do
    puts "Loading translations"
    ActiveadminSelleoCms::Translation.load_translations!
  end
end