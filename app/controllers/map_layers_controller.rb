class MapLayersController < ApplicationController

  def show
    respond_to do |format|
      format.json { 
        render json: {
            type: 'FeatureCollection',
            features: CensusTract.includes(:low_access_low_income_tract_shares).where(state: params[:id].upcase).map(&:geojson_feature)
        }
      }
    end
  end

end
