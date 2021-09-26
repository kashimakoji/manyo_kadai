class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
    @tasks = @tasks.reorder(end_time: :desc) if params[:sort_expired] == "true"
    @tasks = @tasks.where('task_name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @tasks = @tasks.where(status: params[:status]) if params[:status].present?

    # if params[:status] == "未着手" || "着手中" || "完了"
    # @tasks = @tasks.where('status = ?', params[:status]).pluck(:id)
    # binding.irb
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

  def update
    @task.update(task_params)
    redirect_to tasks_path, notice: "「#{@task.task_name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "「#{@task.task_name}」を削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :end_time, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
