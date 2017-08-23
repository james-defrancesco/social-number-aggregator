class InfluencersController < ApplicationController
  before_action :set_influencer, only: [:show, :edit, :update, :destroy]
  after_action :update_user_numbers, only: :index

  # GET /influencers
  # GET /influencers.json
  def index
    @influencers = Influencer.alphabetically
  end

  # GET /influencers/1
  # GET /influencers/1.json
  def show
  end

  # GET /influencers/new
  def new
    @influencer = Influencer.new
  end

  # GET /influencers/1/edit
  def edit
  end

  # POST /influencers
  # POST /influencers.json
  def create
    @influencer = Influencer.new(influencer_params)
    respond_to do |format|
      if @influencer.save
        format.html { redirect_to @influencer, notice: 'Influencer was successfully created.' }
        format.json { render :show, status: :created, location: @influencer }
      else
        format.html { render :new }
        format.json { render json: @influencer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /influencers/1
  # PATCH/PUT /influencers/1.json
  def update
    respond_to do |format|
      if @influencer.update(influencer_params)
        format.html { redirect_to @influencer, notice: 'Influencer was successfully updated.' }
        format.json { render :show, status: :ok, location: @influencer }
      else
        format.html { render :edit }
        format.json { render json: @influencer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /influencers/1
  # DELETE /influencers/1.json
  def destroy
    @influencer.destroy
    respond_to do |format|
      format.html { redirect_to influencers_url, notice: 'Influencer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_influencer
    @search = Influencer.search(params[:search])
  end

  def search
    redirect_to search_influencer_path(params[:q])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_influencer
      @influencer = Influencer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def influencer_params
      params.require(:influencer).permit(:full_name, :facebook, :instagram, :twitter, :youtube)
    end
    
    def update_user_numbers
      Influencer.all.each do |influencer|
        next unless influencer.last_checked < 30.minutes.ago
        params = {
          ig:           Influencer.get_instagram_numbers(influencer.instagram),
          tw:           Influencer.get_twitter_numbers(influencer.twitter),
          yt:           Influencer.get_youtube_numbers(influencer.youtube),
          last_checked: Time.now
        }
        influencer.update_attributes params
      end
    end
end
