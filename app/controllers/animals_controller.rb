class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # GET /animals.json
  def index
    
    # check for search params
    @animals = Animal.where(
      "name like :name and animaltype like :type and outcometype like :outcometype",
      {name: "%#{params[:name]}%", type: "%#{params[:type]}%", outcometype: "%#{params[:outcometype]}%"}
    )
    
    # grab number of results to display back to user
    @results_count = @animals.count
    
    # paginate results 
    @animals = @animals.order("intake_date DESC").paginate(:page => params[:page], :per_page => 500)
    
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
    if (params[:intake_date]) 
      params[:intake_date] = params[:intake_date].strftime('%-m/%-d/%Y')
      puts("!!!!")
    end
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: 'Animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :birthday, :outcometype, :outcomesubtype, :animaltype, :sex, :breed, :color, :intake_date, :outcome_date)
    end
end
