require 'rails_helper'

RSpec.describe Address, type: :model do
  it "is valid with valid attributes" do
    @address = Address.new(street: 'Eliyahu', city: 'Hanavi', country: 'SF')
    expect(@address).to be_valid
  end

  it "is not valid with missing attributes" do
    @address = Address.new(street: 'Eliyahu', city: 'Hanavi')
    expect(@address).to_not be_valid
  end

  it "generates a full address" do
    @address = Address.new(street: '12 Florida st.', city: 'ST', state: 'CA', country: 'USA')
    expect(@address.generate_full_address).to eq('12 Florida st. ST CA USA')
  end
end
