require 'spec_helper'

module ActiveadminSelleoCms

  describe ActiveadminSelleoCms::Page do

    it "should initialize translations for all enabled locales" do
      page = FactoryGirl.build(:page)
      page.translations.should be_empty
      page.initialize_missing_translations
      page.translations.map(&:locale).sort.should == Locale.available_locale_codes.sort
    end

    it "should maintain the published_at date" do
      page = FactoryGirl.create(:page)
      page.published_at.should be_nil
      page.update_attribute(:is_published, true)
      page.published_at.should be_a_kind_of ActiveSupport::TimeWithZone
      page.update_attribute(:is_published, false)
      page.published_at.should be_nil
    end

    it "should set default layout" do
      page = FactoryGirl.create(:page)
      page.layout.should == "application"
    end

    it "should return all section names" do
      page = FactoryGirl.create(:page)
      page.section_names.should include("header", "content", "footer")
    end

    it "should initialize all missing sections" do
      page = FactoryGirl.create(:page)
      page.sections.should be_empty
      page.initialize_missing_sections
      page.sections.map(&:name).should include("header", "content", "footer")
    end

    it "should return translated attribute" do
      page = FactoryGirl.build(:page, title: 'Title_EN')
      page.translations << Page::Translation.new(locale: 'pl', title: 'Title_PL')
      page.save
      page.title.should == "Title_EN"
      page.translated_attribute(:title, :pl).should == "Title_PL"
    end

  end

end
