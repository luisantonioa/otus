class SickbeardController < ApplicationController

  VERSION = "0.1"

  def api
    resp        = HTTParty.get('https://nzbx.co/api/recent?category=tvhd')
    items       = ActiveSupport::JSON.decode(resp.body)
    @feed_items = items.select{|i| i.name =~ /S\d{2}E\d{2}[\S]+(720|1080|HDTV)/i}
    @title      = "Agelian's Aggregator v#{VERSION}"
    @root_url   = "#{request.scheme}://#{request.host_with_port}"
    response.headers["Content-Type"] = 'text/xml'
  end

  def nzb
    resp      = HTTParty.get("https://nzbx.co/api/details?guid=#{params[:id]}")
    item_data = ActiveSupport::JSON.decode(resp.body)
    nzb_url   = item_data.nzb
    redirect_to nzb_url
  end

  private

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end 
end