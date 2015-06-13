class SlingsController < ApplicationController
  before_action :set_sling, only: [:show, :edit, :update, :destroy]

  # GET /slings
  # GET /slings.json
  def index
    @slings = Sling.all
  end

  # GET /slings/1
  # GET /slings/1.json
  def show
  end

  # GET /slings/new
  def new
    @sling = Sling.new
  end

  # GET /slings/1/edit
  def edit
  end

  # POST /slings
  # POST /slings.json
  def create
    @sling = Sling.new(sling_params)

    respond_to do |format|
      if @sling.save
        format.html { redirect_to @sling, notice: 'Sling was successfully created.' }
        format.json { render :show, status: :created, location: @sling }
      else
        format.html { render :new }
        format.json { render json: @sling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slings/1
  # PATCH/PUT /slings/1.json
  def update
    respond_to do |format|
      if @sling.update(sling_params)
        format.html { redirect_to @sling, notice: 'Sling was successfully updated.' }
        format.json { render :show, status: :ok, location: @sling }
      else
        format.html { render :edit }
        format.json { render json: @sling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slings/1
  # DELETE /slings/1.json
  def destroy
    @sling.destroy
    respond_to do |format|
      format.html { redirect_to slings_url, notice: 'Sling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sling
      @sling = Sling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sling_params
      params.require(:sling).permit(:brand_id, :name, :weight, :colors, :blend, :release_date, :link, :status)
    end
end
