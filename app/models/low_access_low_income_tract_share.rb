class LowAccessLowIncomeTractShare < ActiveRecord::Base

  validate :fips, presence: true
  validate :share, presence: true

  def self.import_from_csv(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read
    
    data.each do |row|
      LowAccessLowIncomeTractShare.create(fips: row[headers.index('CensusTract')], share: row[headers.index('lalowi10share')], distance: 10)
    end
  end

end
