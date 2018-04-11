class Address < ApplicationRecord
  #geocoded_by :full_address
  #after_validation :geocode

  # def geocode_address(address_params)
  #   puts 'here::'
  #   puts address_params[:street]
  #   full_address = address_params[:street] + ' ' + address_params[:city] + ' ' + address_params[:state] +
  #     ' ' + address_params[:country] + ' ' + address_params[:zipcode]
  #   puts full_address
  # end

  # def full_address(address_params)
  #   address_params[:street] + ' ' + address_params[:city] + ' ' + address_params[:state] +
  #     ' ' + address_params[:country] + ' ' + address_params[:zipcode]
  # end

  def full_address
    address = self.street + ' ' + self.city + ' ' + self.state

    if !self.country.nil?
      address += ' '
      address += self.country
    end
      
    if !self.zipcode.nil?
      address += ' '
      address += self.zipcode.to_s
    end

    address
  end

  #AIzaSyDNG0ihVr0FUxlzquiVvInxvPPTwRRdXa8
end
