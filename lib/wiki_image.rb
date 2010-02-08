class WikiImage
  def initialize(keyword)
    @keyword=CGI.escape(keyword)
    @imagelist=CGI.escape(get_images.join("|"))
  end

  def getImages
     @images=get_imageinfo(@imagelist)
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
  
  def get_imageinfo(files)
    result=Array.new
    iiprop=CGI.escape("timestamp|user|url|dimensions|comment")
    doc=Nokogiri::XML(open("http://en.wikipedia.org/w/api.php?format=xml&action=query&prop=imageinfo&titles=#{files}&iiprop=#{iiprop}"))

    element=doc.xpath("//api/query/pages/page/imageinfo/ii").each do |element| 
      img=Hash.new
      element.attributes.each do |a|
        img[a[0].to_sym]=element.get_attribute(a[0])
      end  
      result << img
    end
    result
  end
  
end
