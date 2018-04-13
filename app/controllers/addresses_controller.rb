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

    if @address.invalid?
      flash[:error] = 'Could not save. the data you entered is invalid.'
    end

    full_address = @address.full_address #(address_params)
    #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
  #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + full_address + '&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
    #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=49 Kuku St, Kfar Saba Israel&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')


    results =[] #response.parsed_response['results']
  
  if !results.empty?
    @address.latitude = 1 #results[0].dig('geometry', 'location', 'lat')
    @address.longitude = -2 #results[0].dig('geometry', 'location', 'lng')
    @address.save

    if !@address.valid?
      render :index, status: :unprocessable_entity
    end

    if @address.valid?
      # success msg

      redirect_to root_path
    end
  else
    @no_address_msg = 'Can not geocode this address. Please try again.'
    p @no_address_msg
    redirect_to root_path(@no_address_msg)

  end

   #Address.create(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

end
