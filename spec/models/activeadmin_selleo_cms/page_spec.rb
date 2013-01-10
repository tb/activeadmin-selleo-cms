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
      page = FactoryGirl.create(:page, is_published: false)
      page.published_at.should be_nil
      page.update_attribute(:is_published, true)
      page.published_at.should be_a_kind_of ActiveSupport::TimeWithZone
      page.update_attribute(:is_published, false)
      page.published_at.should be_nil
    end

    it "should set default layout" do
      page = FactoryGirl.create(:page)
      page.layout.should_not be_blank
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

    it "should retrun nested path" do
      parent = FactoryGirl.create(:page, title: 'Parent')
      parent.to_param.should == "parent"
      child = FactoryGirl.create(:page, title: 'Child', parent: parent)
      child.to_param.should == "parent/child"
      grand = FactoryGirl.create(:page, title: 'Grand', parent: child)
      grand.to_param.should == "parent/child/grand"
    end

    it "should not be possible to create 2 pages with the same title for same parent" do
      FactoryGirl.create(:page, title: 'Parent')
      expect { FactoryGirl.create(:page, title: 'Parent') }.to raise_error
    end

    it "should be possible to create 2 pages with the same title for same parent but in different languages" do
      FactoryGirl.create(:page, title: 'Same title')
      I18n.locale = :pl
      FactoryGirl.create(:page, title: 'Same title')
    end

    it "should be posbbile to create 2 pages with the same name for different parents" do
      parent1 = FactoryGirl.create(:page, title: 'Parent 1')
      parent2 = FactoryGirl.create(:page, title: 'Parent 2')
      FactoryGirl.create(:page, title: 'Same title')
      FactoryGirl.create(:page, title: 'Same title', parent: parent1)
      FactoryGirl.create(:page, title: 'Same title', parent: parent2)
    end

  end

end
