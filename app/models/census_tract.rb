require 'csv'
require 'open-uri'

class CensusTract < ApplicationRecord
  scope :al, -> { where(state: 'AL') }
  scope :fl, -> { where(state: 'FL') }
  scope :la, -> { where(state: 'LA') }
  scope :ms, -> { where(state: 'MS') }

  has_many :low_access_low_income_tract_shares, foreign_key: :fips, primary_key: :fips

  validates :fips, presence: true
  serialize :boundary

  def self.import_from_csv(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read

    data.each do |row|
      CensusTract.create(fips: row[headers.index('CensusTract')], state: row[headers.index('State')], county: row[headers.index('County')])
    end
  end

  def self.mark_rural_tracts(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read

    data.each do |row|
      CensusTract.where(fips: row[headers.index('CensusTract')]).each do |tract|
        tract.rural = row[headers.index('Rural')]
        tract.save
      end
    end
  end

  def self.mark_low_vehicle(csv_path)
    csv     = ::CSV.open(csv_path)
    headers = csv.gets
    data    = csv.read

    data.each do |row|
      CensusTract.where(fips: row[headers.index('CensusTract')]).each do |tract|
        tract.low_vehicle = row[headers.index('HUNVFlag')]
        tract.save
      end
    end
  end

  def populate_boundary
    self.boundary = geocode_tract
    save
  end

  def geojson_feature
    usable_distance = choose_store_distance
    {
      type: 'Feature',
      properties: {
        id: self.id,
        state: state,
        county: county,
        lalits: low_access_low_income_tract_shares.select { |share| share.distance == usable_distance }.first.share,
        distance: usable_distance,
        sw: southwest_corner_point,
        ne: northeast_corner_point,
        center: average_coordinates
      },
      geometry: geometry
    }
  end

  def geometry
    mappable_points = []
    boundary.each_with_index do |point, index|
      next if point == boundary.last || (point.first > boundary[index-1].first && point.first > boundary[index+1].first || point.first < boundary[index-1].first && point.first < boundary[index+1].first || point.last > boundary[index-1].last && point.last > boundary[index+1].last || point.last < boundary[index-1].last && point.last < boundary[index+1].last)
      if boundary.count > 500
        mappable_points << point if index % 2 == 0
      else
        mappable_points << point
      end
    end

    {
      type: 'Polygon',
      coordinates: [mappable_points << mappable_points.first]
    }
  end

  private

  def choose_store_distance
    !rural || low_vehicle ? 1 : 10
  end

  def southwest_corner_point
    south_most = boundary.first.last
    boundary.each do |point|
      south_most = point.last if point.last < south_most
    end
    west_most = boundary.first.first
    boundary.each do |point|
      west_most = point.first if point.first < west_most
    end

    {lat: south_most, lng: west_most}
  end

  def average_coordinates
    average_lat = 0
    boundary.map(&:first).each { |lat| average_lat += lat }
    average_lat = average_lat / boundary.count

    average_lng = 0
    boundary.map(&:last).each { |lng| average_lng += lng }
    average_lng = average_lng / boundary.count

    { lat: average_lat, lng: average_lng }
  end

  def northeast_corner_point
    north_most = boundary.first.last
    boundary.each do |point|
      north_most = point.last if point.last > north_most
    end
    east_most = boundary.first.first
    boundary.each do |point|
      east_most = point.first if point.first > east_most
    end

    { lat: north_most, lng: east_most }
  end

  def geocode_tract
    response = open geocoder_url
    response.lines.first.scan(/new PLatLng\((-?[0-9]{2}\.-?[0-9]{4}),(-?[0-9]{2}\.-?[0-9]{4})\)/).map { |pair| [pair.last.to_f, pair.first.to_f] }
  end

  def geocoder_url
    "http://www.policymap.com/servlets/boundary/get/?t=fips&i=#{fips}&di=51,24&ord=1&ars=1&c=jQuery110203884256037417799_1401567075913&_=1401567075939"
  end
end
