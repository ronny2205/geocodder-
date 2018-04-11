class Address < ApplicationRecord

  def geocode_address(address_params)
    puts 'here::'
    puts address_params[:street]
    full_address = address_params[:street] + ' ' + address_params[:city] + ' ' + address_params[:state] +
      ' ' + address_params[:country] + ' ' + address_params[:zipcode]
    puts full_address
  end
end
