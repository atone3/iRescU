class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]
  before_action :colors, only: [:new, :create, :edit, :update]

  # GET /animals
  # GET /animals.json
  def index
    
    # check for search params
    @animals = Animal.where(
      "name like :name and animaltype like :type and outcometype like :outcometype and outcometype != 'Active'",
      {name: "%#{params[:name]}%", type: "%#{params[:type]}%", outcometype: "%#{params[:outcometype]}%"}
    )
    
    # grab number of results to display back to user
    @results_count = @animals.count
    
    # paginate results 
    @animals = @animals.order("outcome_date DESC, updated_at DESC").paginate(:page => params[:page], :per_page => 500)
    
  end
  
  # GET /animals/intakes
  def intakes
    @animals = Animal.where(outcometype: 'Active').order("animaltype, name")
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
    # initialize dates
    @animal.intake_date = @animal.birthday = @animal.outcome_date = Date.today
  end

  # GET /animals/1/edit
  def edit
    if @animal.intake_date.present?
       @animal.intake_date = @animal.intake_date.strftime("%B %-d, %Y")
    end
    
    if @animal.birthday.present?
      @animal.birthday = @animal.birthday.strftime("%B %-d, %Y")
    end
    
    if @animal.outcome_date.present?
      @animal.outcome_date = @animal.outcome_date.strftime("%B %-d, %Y")
    end
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        if !@animal.enclosure_id.nil?
          Enclosure.find_by_id(@animal.enclosure_id).update_attribute(:animal_id, @animal.id)
        end
        format.html { redirect_to @animal }
        flash[:success] = 'Record was successfully created.'
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
    enclosure = @animal.enclosure_id
    
    respond_to do |format|
      if @animal.update(animal_params)
        
        if @animal.enclosure_id != enclosure && !enclosure.nil?
          Enclosure.find_by_id(enclosure).update_attribute(:animal_id, "") # clear previous
        end
        
        if !@animal.enclosure_id.nil?
          Enclosure.find_by_id(@animal.enclosure_id).update_attribute(:animal_id, @animal.id)
        end
        
        format.html { redirect_to @animal}
        flash[:success] = 'Record was successfully updated.'
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
      if !@animal.enclosure_id.nil?
        Enclosure.find_by_id(@animal.enclosure_id).update_attribute(:animal_id, "")
      end
      format.html { redirect_to animals_url }
      flash[:success] = 'Record was successfully deleted.'
      format.json { head :no_content }
    end
  end
  
  def adoptions 
  #  @animal = Animal.select("id, outcome_date").where(outcometype: "Adoption")
   # @animals = @animal.group_by { |t| t.outcome_date.year }
    if (params[:report_breed].nil?)
     breed = "Cat" #default to Cat if not present since 1st in list
    else
     breed = params[:report_breed]
    end
   
   if params[:report] == "Adoptions by Breed"
     
      @adoptions = Animal.select("breed, count(id) as adoptions").where(animaltype: "#{breed}", outcometype: "Adoption").group("breed")
      @adoptions = @adoptions.order("adoptions ASC, breed DESC").to_json
  
   elsif params[:report] == "Outcomes by Breed"

      @adoptions = Animal.select("outcometype, count(id) as totals").where(animaltype: "#{breed}").group("outcometype")
      @adoptions = @adoptions.order("totals ASC, outcometype DESC").to_json

   else
     
      if Rails.env.development?
        @animals = Animal.select("strftime('%Y', outcome_date) as 'outcome_year', count(id) as 'total_id'").where(outcometype: "Adoption").group("strftime('%Y',outcome_date)")
      else 
        #Syntax specific to PostgreSQL
        @animals = Animal.select("EXTRACT(year FROM outcome_date) as outcome_year, count(id) as total_id").where(outcometype: "Adoption").group("EXTRACT(year FROM outcome_date)")
      end
      
      @animals = @animals.order("outcome_year ASC")
      @animal_json = @animals.to_json
    end
    
    #@animals_cleaned = @animals.map{|a| {
    #  :id => a.id, :outcome_date => a.outcome_date.strftime("%Y")
    #}}
    # @animal_json = @animals_cleaned.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:name, :birthday, :outcometype, :outcomesubtype, 
      :animaltype, :sex, :breed, :color, :intake_date, :outcome_date, :enclosure_id, :avatar)
    end
    
    def colors
      @colors = Animal.select("color").distinct.order("color")
    end
end
