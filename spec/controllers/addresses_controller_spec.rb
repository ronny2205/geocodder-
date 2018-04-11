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
    post :create, params: { address: { street: 'Golomb', city: 'Kfar Saba', country: 'Israel', zipcode: '66677' } }
    #expect(response).to redirect_to root_path

    address = Address.last
    expect(address.street).to eq("Golomb")
    expect(address.city).to eq("Kfar Saba")
    expect(address.country).to eq("Israel")
  end
end
end
