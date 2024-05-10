class WatchesController < ApplicationController
  before_action :set_watch, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /watches or /watches.json
  def index
    @watches = Watch.all
  end

  # GET /watches/1 or /watches/1.json
  def show
  end

  # GET /watches/new
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

    respond_to do |format|
      if @watch.save
        format.html { redirect_to watch_url(@watch), notice: "Watch was successfully created." }
        format.json { render :show, status: :created, location: @watch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watches/1 or /watches/1.json
  def update
    respond_to do |format|
      if @watch.update(watch_params)
        format.html { redirect_to watch_url(@watch), notice: "Watch was successfully updated." }
        format.json { render :show, status: :ok, location: @watch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watches/1 or /watches/1.json
  def destroy
    @watch.destroy!

    respond_to do |format|
      format.html { redirect_to watches_url, notice: "Watch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @watch = current_user.watches.find_by(id params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_params
      params.require(:watch).permit(:name, :description, :category, :price, :photo_url, :user_id)
    end
end
