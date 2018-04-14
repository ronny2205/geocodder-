class AddressesController < ApplicationController
  HTTP_OK_STATUS = 200

  def index
    @addresses = Address.all.order('created_at desc')
    @address = Address.new

#response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8')
  
#puts response.body #, response.code, response.message, response.headers.inspect


  end

  def create
    @address = Address.new(address_params) #can be avoided?

    # if @address.valid?
    #   redirect_to root_path
    # else
    #   render :index, status: :unprocessable_entity

    # end

# p @address.errors.inspect
#     if @address.errors.include?(:street)
#       @street_err = 'Please enter'
#     end

    # if @address.invalid?
    #   flash[:error] = 'Could not save. the data you entered is invalid.'
    # end

    if @address.valid?
      full_address = @address.generate_full_address 
      response = call_google_maps_api(full_address)

      if response.code != HTTP_OK_STATUS
        flash[:error] = 'An error occured. Please try again later.'
        redirect_to root_path
      end

      results = response.parsed_response['results']
  
      if results.empty?
        flash[:error] = 'Can not geocode this address. Please try again.'
        redirect_to root_path
      else
        @address.latitude = results[0].dig('geometry', 'location', 'lat')
        @address.longitude = results[0].dig('geometry', 'location', 'lng')
       #ActiveRecord::Base::sanitize_sql_hash_for_assignment({ latitude: results[0].dig('geometry', 'location', 'lat'), longitude: results[0].dig('geometry', 'location', 'lng')}, @address)


        # Save only if this address does not exist in the database yet    
        @existing_address = Address.where(["latitude = ? AND longitude = ?", @address.latitude, @address.longitude]).first

        if @existing_address.nil?
          @address.save
          if !@address.valid?
            render :index, status: :unprocessable_entity
          end
        end

        flash[:success] = 'The address <strong>' + full_address + '</strong> was successfully geocoded. Latitude: <strong>' + @address.latitude.to_s + '</strong>. Longitude: <strong>' + @address.longitude.to_s + '</strong>.'
        redirect_to root_path
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

  def call_google_maps_api(full_address)
    initial_url = 'https://maps.googleapis.com/maps/api/geocode/json?address='
    HTTParty.get(initial_url + full_address + '&key=' + ENV['GOOGLE_MAPS_API_KEY'])
  end

end
