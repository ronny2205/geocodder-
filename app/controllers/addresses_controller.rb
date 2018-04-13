class AddressesController < ApplicationController
  def index
    @addresses = Address.all.order('created_at desc')
    @address = Address.new

    @message_to_display = params[:message_to_display] if params[:message_to_display]


    #response = HTTParty.get('http://api.stackexchange.com/2.2/questions?site=stackoverflow')
#response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
#puts response.body #, response.code, response.message, response.headers.inspect


  end

  def create
    @address = Address.new(address_params) #can be avoided?
# p @address.errors.inspect
#     if @address.errors.include?(:street)
#       @street_err = 'Please enter'
#     end

    # if @address.invalid?
    #   flash[:error] = 'Could not save. the data you entered is invalid.'
    # end

    full_address = @address.generate_full_address 

    response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + full_address + '&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
    #response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=49 Kuku St, Kfar Saba Israel&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')


    results = response.parsed_response['results']
  
  if !results.empty?
    @address.latitude = results[0].dig('geometry', 'location', 'lat')
    @address.longitude = results[0].dig('geometry', 'location', 'lng')

    # Save only if this address do not exist in the database yet
    @existing_address = Address.where(:latitude => @address.latitude).where(:longitude=>@address.longitude).first

    if @existing_address.nil?
      @address.save

      if !@address.valid?
        render :index, status: :unprocessable_entity
      end
    end

    #if @address.valid?
      # success msg
      flash[:success] = 'The address <strong>' + full_address + '</strong> was successfully geocoded. Latitude: <strong>' + @address.latitude.to_s + '</strong>. Longitude: <strong>' + @address.longitude.to_s + '</strong>.'

      redirect_to root_path
      #redirect_to root_path(message_to_display: 'The address: ' + full_address + ' was successfully geocoded')
      #(@thing, foo: params[:foo])
    #end
  else
    # no_address_msg = 'Can not geocode this address. Please try again.'
    # redirect_to root_path(message_to_display: no_address_msg)
    flash[:error] = 'Can not geocode this address. Please try again.'
    redirect_to root_path

  end

   #Address.create(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

end
