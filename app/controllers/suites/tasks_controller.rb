class Suites::TasksController < ApplicationController
  before_action :set_suite
  before_action :set_suite_task, only: [:destroy]
  before_action :authenticate_admin!

  def index
    @suite_tasks = @suite.suite_tasks.sort_by(&:priority)
  end

  def new
    @suite_task = SuiteTask.new
    suite_tasks_ids = SuiteTask.select(:task_id).where(suite_id: @suite.id ).to_a.map {|suite_task| suite_task.task_id}
    @task_options = Task.select(:id, :title).where.not(id: suite_tasks_ids).to_a.map {|task| [task.title, task.id]}
  end

  def create
    @suite_task = SuiteTask.new(suite_task_params.merge({ suite_id: @suite.id }))

    respond_to do |format|
      if @suite_task.save
        format.html { redirect_to suite_tasks_path(@suite), notice: 'Task was successfully added to suite.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suite_task.destroy
    respond_to do |format|
      format.html { redirect_to suite_tasks_url(@suite), notice: 'Suite task was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_suite
      @suite = Suite.find(params[:suite_id])
    end

    def set_suite_task
      @suite_task = SuiteTask.where(task_id: params[:id], suite_id: @suite.id).first
      raise "Couldn't find suite task for task `#{params[:id]}` and suite `#{@suite.id}`" unless @suite_task
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suite_task_params
      params.require(:suite_task).permit(:task_id, :priority)
    end
end
