class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.where(user_id: current_user).order(priority: :desc, due_date: :asc)
  end

  # GET /tasks/:id
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/:id/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task '#{@task.title}' was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /tasks/:id
  def destroy
    title = @task.title
    @task.destroy
    redirect_to tasks_url, notice: "Task #{title} was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find_by(id: params[:id], user: current_user)
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params
      .require(:task)
      .permit(:title, :description, :priority, :due_date, :completed)
  end
end
