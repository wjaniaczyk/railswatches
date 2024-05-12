class WatchesController < ApplicationController
include Orderable

  before_action :set_watch, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:destroy]

  # GET /watches or /watches.json
  # GET /watches?name=a 
  # GET /watches?price_min=1
  # GET /watches?price_max=100 
  # GET /watches?category=0,1,2 
  def index
    # @watches = Watch.all

    @watches = Watch.where(nil) # creates an anonymous scope
    @watches = @watches.filter_by_name(params[:name]) if params[:name].present?
    @watches = @watches.filter_by_price_min(params[:price_min]) if params[:price_min].present?
    @watches = @watches.filter_by_price_max(params[:price_max]) if params[:price_max].present?
    @watches = @watches.filter_by_category(params[:category]) if params[:category].present?

    @watches = @watches.order(ordering_params(params)).all

    render json: @watches
  end
 
  # GET /watches/1 or /watches/1.json
  def show
    # render json: @watch
  end

  # # GET /watches/new
  def new
    # @watch = Watch.new
    @watch = current_user.watches.build
  end

  # GET /watches/1/edit
  def edit
  end

  # POST /watches or /watches.json
  def create
    # @watch = Watch.new(watch_params)
    @watch = current_user.watches.build(watch_params)

    if @watch.save
      render json: @watch
    else
      render json: {error: 'Error creating watch'}
    end

  end

  # PATCH/PUT /watches/1 or /watches/1.json
  def update
    @watch = Watch.find(params[:id])
        if @post.update(watch_params)
            render json: @watch
        else
            render json: {error: 'Error updating watch'}
        end
  end

  # DELETE /watches/1 or /watches/1.json
  def destroy
    @watch = Watch.find(params[:id])
    if @watch.destroy
        render status: :ok
    else
        render json: {error: 'Error deleting watch'}
    end
  end

  def correct_user
    @watch = current_user.watches.find_by(id: params[:id])
  end

  private

    def authorize_user
      watch = @watch || Watch
      authorize watch
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_params
      params.require(:watch).permit(:name, :description, :category, :price, :photo_url, :user_id)
    end
end
