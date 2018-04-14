class AddressesController < ApplicationController
  HTTP_OK_STATUS = 200

  def index
    @address = Address.new
    @addresses = Address.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end

  def create
    @address = Address.new(address_params) 
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
        # Getting the latitude and the longitude from the json response object
        @address.latitude = results[0].dig('geometry', 'location', 'lat')
        @address.longitude = results[0].dig('geometry', 'location', 'lng')

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
