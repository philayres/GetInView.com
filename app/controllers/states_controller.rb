class StatesController < PublicController
  before_action :set_state, only: [:show]

  
  def index
    if params[:country_id].blank? && params[:state_name].blank?
      @states = State.all
    else
      if !params[:country_id].blank?
        @country = Country.find(params[:country_id])
        return not_found unless @country
        @states = @country.states
      elsif !params[:state_name].blank?
        sn = params[:state_name]
        @states = State.where "name like ? or name like ?", "#{sn}%", "% #{sn}%"
      end
    end
    fresh_when @states
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    redirect_to cities_path(state_id: @state.id)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.fetch(:state, {})
    end
end
