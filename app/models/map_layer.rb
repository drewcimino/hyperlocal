class MapLayer < ApplicationRecord
  validates :name, presence: true
  validates :geojson_data, presence: true

  serialize :geojson_data

  def self.build_json(features)
    {
      type: 'FeatureCollection',
      features: features
    }
  end
end
