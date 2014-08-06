class HealthCenter < ActiveRecord::Base

  validates :name, :operator, :latitude, :longitude, :street, :city, :state, :zip, presence: true

  def match_address
    "#{street}, #{city}, #{state} #{zip}"
  end

end
