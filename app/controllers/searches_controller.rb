class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1Q0DQSV5I1QQ3FBYEV2FCW5ISLLLDARSGYTGHDD3ZITE3Q2A'
      req.params['client_secret'] = 'LNR4EODLC2FMXJEED0OTF3L4V30GDGBBMPSKCJ5QQZBMJZVF'
      req.params['v'] = '20190920'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 1000
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

end
