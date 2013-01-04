require 'spec_helper'

module ActiveadminSelleoCms

  describe ActiveadminSelleoCms::Section do

    it "should initialize translations for all enabled locales" do
      section = Section.new
      section.translations.should be_empty
      section.initialize_missing_translations
      section.translations.map(&:locale).sort.should == Locale.available_locale_codes.sort
    end

    it "should return translated attribute" do
      section = Section.new(name: 'content', body: 'Content_EN')
      section.translations << Section::Translation.new(locale: 'pl', body: 'Content_PL')
      section.save
      section.body.should == "Content_EN"
      section.translated_attribute(:body, :pl).should == "Content_PL"
    end

  end

end
