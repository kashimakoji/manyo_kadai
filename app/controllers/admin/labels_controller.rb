class Admin::LabelsController < ApplicationController
  before_action :require_admin
  before_action :set_label, only: [:edit, :update, :destroy]

  def new
    @label = Label.new
    @labels = Label.includes(:tasks).all
    # @labels = Label.all
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to new_admin_label_path, notice: "ラベル「#{@label.name}」を作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @label.update(label_params)
    redirect_to new_admin_label_path, notice: "ラベル「#{@label.name}」を更新しました"
  end

  def destroy
    @label = Label.find(params[:id])
    if @label.destroy
      redirect_to new_admin_label_path, notice: "ラベル「#{@label.name}」を削除しました"
    else
      render :new
    end
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end

  def require_admin
    redirect_to tasks_path  unless current_user.admin?
    # flash[:notice] = '管理者のみアクセスできます！'
  end

end
