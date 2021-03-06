WikiImage
=========

This is a simple plugin which allows you to grab images stored in Wikipedia (or better WikiCommons). It does not do scraping but uses a subset of the [MediaWiki API](http://www.mediawiki.org/wiki/API "MediaWiki API").

Requirements
------------

- open-uri
- nokogiri
- cgi

Install
-------

`./script/plugin install git://github.com/fuxowitsch/WikiImage.git`

Example
-------

`images=WikiImage.new("Douglas Adams").getImages`

This will return an array of hashes with the following keys:

    :url            Link to the image
    :size           Size of the image in bytes
    :descriptionurl Link to the description page on Wikipedia 
    :width          Width in Pixels
    :height         Height in Pixels
    :user           The user who uploaded the image and probably owns it (copyright holder might be different)
    :timestamp      Last modified
    :comment        Wikipedia comment info in wiki text


`images=WikiImage.new("Douglas Adams").getImages(:globalusage).first`

This returns the global usage on all WikiPedia pages for the first image found:

    :title          The page title
    :url            The wiki url
    :wiki           The wikipedia domain (e.g. de.wikipedia.org)

You can also access the imagelist as represented in Wikipedia:

`list = WikiImage.new("Fred Flintstone").imagelist`

If you did use getImages on both properties you can access the stockpile which gives you a hash on all data:

    obj=WikiImage.new("Fred Astaire")
    obj.getImages(:imageinfo)
    obj.getImages(:globalusage)
    everything=obj.stockpile

everything will then contain - well everything ;)

Note!
-----
Always show a link to the license (:descriptionurl) and name the Author (:user)

Tests
-----
Assuming you have rspec installed you can run the tests within the plugin directory by invoking rake. 

ToDo
----
- Filter images only. Currently also other media content is returned
- Get more description content from the actual wiki page
- Ideas?



Copyright (c) 2010 Bernhard Fuchs, released under the MIT license
