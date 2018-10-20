class LowAccessLowIncomeTractShare < ApplicationRecord
  validates :fips, presence: true
  validates :share, presence: true

  belongs_to :census_tract, foreign_key: :fips, primary_key: :fips

  def self.import_from_csv(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read

    data.each do |row|
      LowAccessLowIncomeTractShare.create(fips: row[headers.index('CensusTract')], share: row[headers.index('lalowi10share')], distance: 10)
    end
  end
end
