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
    end

    it "should set default layout name" do
      page = FactoryGirl.create(:page)
      page.layout_name.should_not be_blank
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

    it "should be possible to create and update page with nested translations" do
      page = Page.create(translations_attributes: { "0" => { title: "Title EN", slug: "title-en", locale: "en" }, "1" => { locale: "da" } } )
      page.translations.count.should == 2
      page_en_translation = page.translations.where(locale: 'en').first
      page_en_translation.title.should == "Title EN"
      page_da_translation = page.translations.where(locale: 'da').first
      page_da_translation.title.should be_nil

      attrs = { translations_attributes: {} }
      attrs[:translations_attributes][page_en_translation.id] = { title: "Updated EN", id: page_en_translation.id }
      attrs[:translations_attributes][page_da_translation.id] = { title: "New DA", id: page_da_translation.id, slug: 'new-da' }

      page.update_attributes(attrs)
      page.reload
      page.translations.count.should == 2

      page.translations.where(locale: 'en').first.title.should == "Updated EN"
      page.translations.where(locale: 'da').first.title.should == "New DA"

      attrs = { translations_attributes: {} }
      attrs[:translations_attributes][page_da_translation.id] = { title: "Updated DA", id: page_da_translation.id }

      page.update_attributes(attrs)
      page.reload
      page.translations.count.should == 2

      page.translations.where(locale: 'da').first.title.should == "Updated DA"
    end

    it "should be possible to create and update page with nested sections" do
      page = Page.create(
          translations_attributes: { "0" => { title: "Title EN", slug: "title-en", locale: "en" }, "1" => { locale: "da" } },
          sections_attributes: { "0" => { name: 'header', translations_attributes: { "0" => { body: 'Header EN', locale: 'en' }, "1" => { locale: 'da' } } } }
      )
      page.sections.count.should == 1
      page.sections.first.translations.count.should == 2
      page_section = page.sections.first
      page_en_section_translation = page_section.translations.where(locale: 'en').first
      page_en_section_translation.body.should == "Header EN"
      page_da_section_translation = page_section.translations.where(locale: 'da').first
      page_da_section_translation.body.should be_nil

      attrs = { sections_attributes: { page_section.id => { id: page_section.id, translations_attributes: {} } } }
      attrs[:sections_attributes][page_section.id][:translations_attributes][page_en_section_translation.id] = { body: "Updated EN header", id: page_en_section_translation.id }
      attrs[:sections_attributes][page_section.id][:translations_attributes][page_da_section_translation.id] = { body: "New DA header", id: page_da_section_translation.id }

      page.update_attributes(attrs)
      page.reload
      page.sections.count.should == 1
      page.sections.first.translations.count.should == 2
      page_section = page.sections.first

      page_section.translations.where(locale: 'en').first.body.should == "Updated EN header"
      page_section.translations.where(locale: 'da').first.body.should == "New DA header"

      attrs = { sections_attributes: { page_section.id => { id: page_section.id, translations_attributes: {} } } }
      attrs[:sections_attributes][page_section.id][:translations_attributes][page_da_section_translation.id] = { body: "Updated DA header", id: page_da_section_translation.id }

      page.update_attributes(attrs)
      page.reload
      page.sections.count.should == 1
      page.sections.first.translations.count.should == 2
      page_section = page.sections.first

      page_section.translations.where(locale: 'da').first.body.should == "Updated DA header"
    end

    it "should create dynamic getters and setters from settings" do
      page = FactoryGirl.create(:page, title: 'Test 1', settings: {:attr1 => 'Test 1'})
      page.attr1
      page = FactoryGirl.create(:page, title: 'Test 2', settings: {:attr2 => 'Test 2'})
      page.attributes = { :attr2 => 'Test' }
      page = FactoryGirl.create(:page, title: 'Test 3', settings: {:attr3 => 'Test 3'})
      page.attr3 = 'Test'
    end

  end

end
