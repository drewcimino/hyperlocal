class MapLayersController < ApplicationController

  def show
    @map_layer = MapLayer.find(params[:id])
    respond_to do |format|
      format.json { render json: @map_layer.geojson_data }
    end
  end

  def create

  end

end
