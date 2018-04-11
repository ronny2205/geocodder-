class AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.create(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zipcode)
  end

end
