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
  
  it "should have lots of global usage links for John Cleese" do
    image=WikiImage.new("John Cleese").getImages(:globalusage).first
    [:title,:url,:wiki].each do |key|
      image[key].should_not be_nil
    end
  end
  
  it "should have something in the imagelist accessor for Albert Einstein" do
    obj=WikiImage.new("John Cleese")
    obj.imagelist.size.should > 0
  end
  
  it "should fill the stockpile" do
    obj=WikiImage.new("John Cleese")
    obj.getImages(:imageinfo)
    obj.getImages(:globalusage)
    firstkey=obj.imagelist.first
    
    [:globalusage,:imageinfo].each do |key|
      obj.stockpile[firstkey][key].should_not be_nil
    end
  end
end