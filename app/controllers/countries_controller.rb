class CountriesController < PublicController
  before_action :set_country, only: [:show]

  
  def index
    @countries = Country.all.sort{|c| c.full_name}
    fresh_when @countries
  end

  
  def show
    redirect_to states_path(country_id: @country.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.fetch(:country, {})
    end
end
