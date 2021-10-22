class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.includes(:labels).desc_sort.page(params[:page]).per(10)
    # @tasks = current_user.tasks.includes(user: :labels).desc_sort.page(params[:page]).per(10)
    # @tasks = current_user.tasks.desc_sort.page(params[:page]).per(10) # N+1問題
    @tasks = @tasks.reorder(end_time: :desc) if params[:sort_expired] == "true"
    @tasks = @tasks.reorder(priority: :desc) if params[:sort_priority] == "true"
    @tasks = @tasks.word_search(params[:search]) if params[:search].present?
    #@tasks = @tasks.where('task_name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @tasks = @tasks.status_search(params[:status]) if params[:status].present?
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    # binding.irb
  end

  def show
    redirect_to tasks_path if @task.blank?
  end

  def new
    @task  = Task.new
  end

  def create
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
    @task = current_user.tasks.build(task_params)
# binding.irb
    @task.end_time = Time.now if @task.end_time.nil?
# binding.irb
    if  @task.save
      redirect_to tasks_path, notice: "「#{@task.task_name}」登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.labellings.delete_all unless params[:task][:label_ids] #空のチェックボックスを許可
    @task.update(task_params)
    redirect_to tasks_path, notice: "「#{@task.task_name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "「#{@task.task_name}」を削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:task_name, :content, :end_time, :status, :priority, :name, :user_id, label_ids: [])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
