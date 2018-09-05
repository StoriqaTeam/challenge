class Profiles::SuiteSolutionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user
  before_action :set_suite_solution, only: [:destroy, :show, :grade]

  def index
    @suite_solutions = SuiteSolution.includes(:suite).where(user_id: @user.id).order(updated_at: :desc)
  end

  def new
    @suite_solution = SuiteSolution.new({ user_id: @user.id })
    @suite_options = Suite.select(:id, :name).to_a.map {|suite| [suite.name, suite.id]}
  end

  def show
  end

  def grade
    @suite_solution.grade
    redirect_to user_suite_solution_path(@user, @suite_solution)
  end


  def create
    @suite_solution = SuiteSolution.new(suite_solution_params.merge({ user_id: @user.id }))

    respond_to do |format|
      if @suite_solution.save
        format.html { redirect_to user_suite_solutions_path(@user), notice: 'Suite solution was successfully added for a user.' }
        format.json { render :show, status: :created, location: @suite_solution }
      else
        format.html { render :new }
        format.json { render json: @suite_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suite_solution.destroy
    respond_to do |format|
      format.html { redirect_to user_suite_solutions_path(@user), notice: 'Suite solution was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_suite_solution
      @suite_solution = SuiteSolution.where(id: params[:id]).first
      raise "Couldn't find suite solution for id `#{params[:id]}`" unless @suite_solution
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def suite_solution_params
      params.require(:suite_solution).permit(:suite_id)
    end

end
