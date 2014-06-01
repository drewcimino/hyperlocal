require 'csv'
require 'open-uri'
class CensusTract < ActiveRecord::Base

  scope :al, -> { where(state: 'AL') }
  scope :fl, -> { where(state: 'FL') }
  scope :la, -> { where(state: 'LA') }
  scope :ms, -> { where(state: 'MS') }

  validate :fips, presence: true
  serialize :boundary

  def self.import_from_csv(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read
    
    data.each do |row|
      CensusTract.create(fips: row[headers.index('CensusTract')], state: row[headers.index('State')], county: row[headers.index('County')])
    end
  end

  def populate_boundary
    self.boundary = geocode_tract
    save
  end

  def geojson_feature
    {
      type: 'Feature',
      properties: {
        state: state,
        county: county,
      },
      geometry: geometry
    }
  end

  def geometry
    mappable_points = []
    boundary.each_with_index do |point, index|
      mappable_points << point if index % 10 == 0
    end

    {
      type: 'Polygon',
      coordinates: [mappable_points << mappable_points.first] 
    }
  end

  private

  def geocode_tract
    response = open geocoder_url
    response.lines.first.scan(/new PLatLng\((-?[0-9]{2}\.-?[0-9]{4}),(-?[0-9]{2}\.-?[0-9]{4})\)/).map { |pair| [pair.first.to_f, pair.last.to_f] }
  end

  def geocoder_url
    "http://www.policymap.com/servlets/boundary/get/?t=fips&i=#{fips}&di=51,24&ord=1&ars=1&c=jQuery110203884256037417799_1401567075913&_=1401567075939"
  end

end
