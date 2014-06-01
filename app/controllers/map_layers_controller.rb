class MapLayersController < ApplicationController

  def show
    @map_layer = MapLayer.find(params[:id])
    respond_to do |format|
      # format.json { render json: @map_layer.geojson_data }
      format.json { render json: { type: 'FeatureCollection', features: CensusTract.all.map(&:geojson_feature) } }
    end
  end

  def create

  end

end
