class TasksuitesController < ApplicationController
  before_action :set_tasksuite, only: [:show, :edit, :update, :destroy]

  # GET /tasksuites
  # GET /tasksuites.json
  def index
    @tasksuites = Tasksuite.all
  end

  # GET /tasksuites/1
  # GET /tasksuites/1.json
  def show
  end

  # GET /tasksuites/new
  def new
    @tasksuite = Tasksuite.new
  end

  # GET /tasksuites/1/edit
  def edit
  end

  # POST /tasksuites
  # POST /tasksuites.json
  def create
    @tasksuite = Tasksuite.new(tasksuite_params)

    respond_to do |format|
      if @tasksuite.save
        format.html { redirect_to @tasksuite, notice: 'Tasksuite was successfully created.' }
        format.json { render :show, status: :created, location: @tasksuite }
      else
        format.html { render :new }
        format.json { render json: @tasksuite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasksuites/1
  # PATCH/PUT /tasksuites/1.json
  def update
    respond_to do |format|
      if @tasksuite.update(tasksuite_params)
        format.html { redirect_to @tasksuite, notice: 'Tasksuite was successfully updated.' }
        format.json { render :show, status: :ok, location: @tasksuite }
      else
        format.html { render :edit }
        format.json { render json: @tasksuite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasksuites/1
  # DELETE /tasksuites/1.json
  def destroy
    @tasksuite.destroy
    respond_to do |format|
      format.html { redirect_to tasksuites_url, notice: 'Tasksuite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tasksuite
      @tasksuite = Tasksuite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tasksuite_params
      params.require(:tasksuite).permit(:task_id, :suite_id)
    end
end
