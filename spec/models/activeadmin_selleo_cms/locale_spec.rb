require 'spec_helper'

module ActiveadminSelleoCms

  describe ActiveadminSelleoCms::Locale do

    it "should find locale using method missing" do
      [:en, :pl].each do |locale_code|
        Locale.send(locale_code).should == Locale.find_by_code(locale_code)
      end
    end

    it "should return root url for locale" do
      Locale.en.url.should == "/en"
    end

    it "should return all enabled locales except the one(s) specified" do
      Locale.pl.update_attribute(:enabled, true)
      Locale.en.update_attribute(:enabled, true)

      Locale.enabled.count.should == 2

      Locale.except(:pl).should_not include(Locale.pl)
      Locale.except(:pl).should include(:en)

      Locale.except([:en,:pl]).should_not include(:pl, :en)
      Locale.except([:en,:pl]).should be_empty
    end
  end

end
