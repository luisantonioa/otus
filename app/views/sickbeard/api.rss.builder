xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", 'xmlns:newznab' => 'http://www.newznab.com/DTD/2010/feeds/attributes/' do
  xml.channel do
    xml.title @title
    xml.description "Aggregated Feeds"
    xml.link nzb_api_path
    xml.language 'en-us'

    for item in @feed_items
      xml.item do
        xml.title item.name
        xml.description ""
        xml.pubDate DateTime.parse(item.postdate)
        xml.link "#{@root_url}#{nzb_path(item.guid)}"
        xml.guid("#{@root_url}#{nzb_path(item.guid)}", :isPermaLink => 'true')
        #xml.enclosure(:url => "#{@root_url}#{nzb_path(item.guid)}", :length => item.size.to_s, :type => 'application/x-nzb')
      end
    end
  end
end