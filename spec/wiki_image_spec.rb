require 'spec_helper'


describe WikiImage, '#image' do 
  it "should find plenty of stuff for Douglas Adams" do
    images=WikiImage.new("Douglas Adams").getImages
    images.size.should > 2
  end
  
  it "should have an image with correct params for Konrad Zuse" do
    image=WikiImage.new("Konrad Zuse").getImages.first
    [:url, :size, :descriptionurl, :width, :height, :user, :timestamp, :comment].each do |key|
      image[key].should_not be_nil
    end
  end
end