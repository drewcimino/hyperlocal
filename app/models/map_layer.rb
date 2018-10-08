class MapLayer < ApplicationRecord
  validate :name, presence: true
  validate :geojson_data, presence: true

  serialize :geojson_data

  def self.build_json(features)
    {
      type: 'FeatureCollection',
      features: features
    }
  end
end
