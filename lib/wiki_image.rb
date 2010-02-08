require 'pp'
class WikiImage
  attr_accessor :imagelist, :keyword, :stockpile
  
  def initialize(keyword)
    @stockpile=Hash.new
    @keyword=CGI.escape(keyword)
    @imagelist=get_images
  end

  def getImages(props=:imageinfo)
     @images=get_imageinfo(CGI.escape(@imagelist.join('|')), props )
  end
  
  private
  
  def get_images
    result=Array.new
    doc = Nokogiri::XML(open("http://en.wikipedia.org/w/api.php?action=query&format=xml&prop=images&titles=#{@keyword}"))
    
    doc.xpath("//api/query/pages/page/images/im").each do |element|
      result << element.get_attribute("title")
    end
    result
  end
  
  def get_imageinfo(files,props = :imageinfo)
    result=Array.new
    
    iiprop=CGI.escape("timestamp|user|url|dimensions|comment")
    doc=Nokogiri::XML(open("http://en.wikipedia.org/w/api.php?format=xml&action=query&prop=#{props.to_s}&titles=#{files}&iiprop=#{iiprop}"))

    xp="//api/query/pages/page/imageinfo/ii"
    xp="//api/query/pages/page/globalusage/gu" if props==:globalusage

    ctr=0
    element=doc.xpath(xp).each do |element| 
      img=Hash.new
      element.attributes.each do |a|
        img[a[0].to_sym]=element.get_attribute(a[0])
      end  
      result << img
    
      @stockpile["#{@imagelist[ctr]}"]=Hash.new unless @stockpile["#{@imagelist[ctr]}"]
      @stockpile["#{@imagelist[ctr]}"][props]=img
      ctr=ctr+1
    end
    result
  end
 
end
