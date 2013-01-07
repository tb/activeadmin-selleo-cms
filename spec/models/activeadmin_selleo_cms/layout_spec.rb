require 'spec_helper'

module ActiveadminSelleoCms

  describe ActiveadminSelleoCms::Layout do

    it "should return filenames of available layouts in application" do
      Layout.all.should include("application", "cms")
    end

  end

end
