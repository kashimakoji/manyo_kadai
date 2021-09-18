class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task  = Task.new
  end

  def create
    @task = Task.new(task_params)
    if  @task.save
      redirect_to tasks_path, notice: "「#{@task.task_name}」登録しました"
    else
      render :new
    end
  end

  def edit
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content)
  end

end
