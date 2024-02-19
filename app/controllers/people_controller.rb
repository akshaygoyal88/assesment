class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  # GET /people or /people.json
  def index
    @people = Person.includes(:detail)
    @selected_person = @people.first
    respond_to do |format|
      format.html { render 'index' } 
      format.json { render json: @people, include: :detail } # Render JSON for API
    end
  end

  # def get_person
  #   render turbo_stream: turbo_stream.replace("person_info", partial: "person_info", locals: { person: Person.find(params[:id]) })
  # end
  # GET /people/1 or /people/1.json
  def show
    render turbo_stream: turbo_stream.replace("person_info", partial: "person_info", locals: { person: Person.find(params[:id]) })

    # respond_to do |format|
    #   format.html { render 'show' } 
    #   format.json { render json: @person, include: :detail } # Render JSON for API
    # end
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.build_detail
   end

  # GET /people/1/edit
  def edit
    @person.build_detail unless @person.detail.present?
   end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: 'Person and detail were successfully created.' }
        format.json { render :show, status: :created, location: @person }

      else
        format.html { render 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_url, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy!

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def person_params
      params.require(:person).permit(:name, :email, detail_attributes: [:email, :title, :age, :phone])
    end
end
