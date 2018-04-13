class Address < ApplicationRecord
  #geocoded_by :full_address
  #after_validation :geocode
  validates :street, :city, :country, presence: true

  US_STATES =
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]

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
