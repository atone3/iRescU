class EnclosuresController < ApplicationController
  before_action :set_enclosure, only: [:show, :edit, :update, :destroy]

  # GET /enclosures
  # GET /enclosures.json
  def index
    @enclosures = Enclosure.all
  end

  # GET /enclosures/1
  # GET /enclosures/1.json
  def show
  end

  # GET /enclosures/new
  def new
    @enclosure = Enclosure.new
  end

  # GET /enclosures/1/edit
  def edit
  end

  # POST /enclosures
  # POST /enclosures.json
  def create
    @enclosure = Enclosure.new(enclosure_params)

    respond_to do |format|
      if @enclosure.save
        format.html { redirect_to @enclosure, notice: 'Enclosure was successfully created.' }
        format.json { render :show, status: :created, location: @enclosure }
      else
        format.html { render :new }
        format.json { render json: @enclosure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enclosures/1
  # PATCH/PUT /enclosures/1.json
  def update
    respond_to do |format|
      if @enclosure.update(enclosure_params)
        format.html { redirect_to @enclosure, notice: 'Enclosure was successfully updated.' }
        format.json { render :show, status: :ok, location: @enclosure }
      else
        format.html { render :edit }
        format.json { render json: @enclosure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enclosures/1
  # DELETE /enclosures/1.json
  def destroy
    @enclosure.destroy
    respond_to do |format|
      format.html { redirect_to enclosures_url, notice: 'Enclosure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enclosure
      @enclosure = Enclosure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enclosure_params
      params.require(:enclosure).permit(:name)
    end
end
