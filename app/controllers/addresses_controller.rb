class AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new

    #response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
#response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
#puts response.body #, response.code, response.message, response.headers.inspect


  end

  def create
    @address = Address.new(address_params) #can be avoided?
    full_address = @address.full_address #(address_params)
    #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + full_address + '&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
    #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=49 Kuku St, Kfar Saba Israel&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')


    results = response.parsed_response['results']
  
  #puts results
  if !results.empty?
    @address.latitude = results[0].dig('geometry', 'location', 'lat')
    @address.longitude = results[0].dig('geometry', 'location', 'lng')
    @address.save
  else
    @no_address_msg = 'Can not geocode this address. Please try again.'
  end
  
   #Address.create(address_params)
    redirect_to root_path
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

end
