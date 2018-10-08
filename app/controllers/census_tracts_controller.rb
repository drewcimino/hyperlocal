class CensusTractsController < ApplicationController
  def index
    params[:state] = 'all' unless %w(al fl la ms).include? params[:state]
    @census_tracts = CensusTract.send(params[:state])

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
