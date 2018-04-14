require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  describe "addressess#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "addressess#create action" do
    it "should successfully create a new address in the database" do
      previous_number_of_addresses = Address.count

      post :create, params: { address: { street: 'Golomb', city: 'Kfar Saba', country: 'Israel', zipcode: '66677' } }
      expect(response).to redirect_to root_path

      address = Address.last
      expect(address.street).to eq("Golomb")
      expect(address.city).to eq("Kfar Saba")
      expect(address.country).to eq("Israel")
      expect(Address.count).to eq(previous_number_of_addresses + 1)
    end

    it "should fail to create a non real address" do
      previous_number_of_addresses = Address.count
      post :create, params: { address: { street: 'Kukukuk', city: 'mumum', country: 'lululu'} }
      expect(response).to redirect_to root_path
      expect(Address.count).to eq(previous_number_of_addresses)
      
    end
  end
end
