class InfluencersController < ApplicationController
  before_action :set_influencer, only: [:show, :edit, :update, :destroy]
  ##after_action :update_users_social, only: [:index]
  after_action :get_user_social, only: [:edit, :update]


  # GET /influencers
  # GET /influencers.json
  def index
    @influencers = Influencer.alphabetically
    @count = get_total_count
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
    get_user_social
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
        get_user_social
        format.html { redirect_to root_path, notice: 'Influencer was successfully updated.' }
        format.json { render :root, status: :ok, location: @influencer }
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
      params.require(:influencer).permit(:first_name, :last_name, :facebook, :instagram, :twitter, :youtube, :company)
    end

    def update_users_social
      Influencer.all.each do |influencer|
        if influencer.last_checked.nil? || influencer.last_checked < 30.minutes.ago
           params = {
            ig:           Influencer.get_instagram_numbers(influencer.instagram),
            tw:           Influencer.get_twitter_numbers(influencer.twitter),
            yt:           Influencer.get_youtube_numbers(influencer.youtube),
            last_checked: Time.now
          }
          next if params.values.any?{|i|i.nil? || i.nil? || i == 0 }
          influencer.update_attributes! params
        else
          next
        end
      end
      redirect_to root_path
    end

    def get_total_count
      count = 0
      Influencer.all.each do |influencer|
        count += (influencer.ig.to_i + influencer.tw.to_i + influencer.yt.to_i)
      end
      count
    end

    def get_user_social
      logger.info "\n\ngetting user info\n\n"
      params = {
        ig:           Influencer.get_instagram_numbers(@influencer.instagram),
        tw:           Influencer.get_twitter_numbers(@influencer.twitter),
        yt:           Influencer.get_youtube_numbers(@influencer.youtube),
        last_checked: Time.now
      }
      logger.info "\n\nuser info:\n\t#{@influencer.instagram}\n\n"
      logger.info "\n\nuser info:\n\t#{params.inspect}\n\n"
      @influencer.update_attributes! params
    end
end
