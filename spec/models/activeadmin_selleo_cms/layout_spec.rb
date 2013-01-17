require 'spec_helper'

module ActiveadminSelleoCms

  describe ActiveadminSelleoCms::Layout do

    it "should return filenames of available layouts in application" do
      Layout.all.should include("application", "cms")
    end

    it "should not return filenames of layouts other than erb" do
      Layout.all.should_not include("haml-layout")
    end

  end

end
