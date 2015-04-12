class JourneysController < ApplicationController
  before_action :set_journey, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_trip!,except:[:index,:show]
  # GET /journeys
  # GET /journeys.json
  def index
    if trip_signed_in?
    @journeys = Journey.where(["trip_id like ?",current_trip.id])
  else
    redirect_to new_trip_session_url
  end
  end

  # GET /journeys/1
  # GET /journeys/1.json
  def show
  end

  # GET /journeys/new
  def new
    

    @journey = current_trip.build_journey
  end

  # GET /journeys/1/edit
  def edit
  end

  # POST /journeys
  # POST /journeys.json
  def create
    @journey = current_trip.build_journey(journey_params)

    respond_to do |format|
      if @journey.save
        format.html { redirect_to root_url, notice: 'Journey was successfully created.' }
        format.json { render :show, status: :created, location: @journey }
      else
        format.html { render :new }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /journeys/1
  # PATCH/PUT /journeys/1.json
  def update
    respond_to do |format|
      if @journey.update(journey_params)
        format.html { redirect_to @journey, notice: 'Journey was successfully updated.' }
        format.json { render :show, status: :ok, location: @journey }
      else
        format.html { render :edit }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journeys/1
  # DELETE /journeys/1.json
  def destroy
    @journey.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Journey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journey
      @journey = Journey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def journey_params
      params.require(:journey).permit(:from, :to, :budget, :by, :peoples, :name)
    end
end
