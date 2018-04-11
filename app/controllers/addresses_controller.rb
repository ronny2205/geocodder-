class AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new #can be avoided?
    @address.geocode_address(address_params)
    #@address = Address.create(address_params)
    redirect_to root_path
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

end
