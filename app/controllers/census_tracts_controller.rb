class CensusTractsController < ApplicationController

  def index

    @census_tracts = CensusTract.all

    respond_to do |format|
      format.json { render json: @census_tracts.map { |tract| tract.geojson_polygon } }
    end
  end

  def show
    @census_tract = CensusTract.find(params[:id])

    respond_to do |format|
      format.json { render json: @census_tract.geojson_polygon }
    end
  end

end
