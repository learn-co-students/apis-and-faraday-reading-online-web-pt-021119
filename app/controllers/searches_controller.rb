require 'pry'

class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'CNVPKRT2D3V0DBMQSNGOJTPVTXLDTACV2AWHBY4DVL2LFY0R'
      req.params['client_secret'] = 'USNTZOTG05QU2QD5ZA2CAP0VMSDYNSGHBUMHHRWE22XXXQ2A'
      req.params['v'] = '20190101'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    # binding.pry
    render 'search'
  end
end
