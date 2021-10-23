class LabelsController < ApplicationController
  #before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @label = Label.new
    # @labels = Label.all
    @labels = current_user.labels.includes(:tasks)
    # binding.irb
  end

  def create
    # @label = Label.new(label_params)
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to new_label_path, notice: "ラベル「#{@label.name}」を作成しました"
    else
      render :new if @labels.invalid?
    end
  end

  def destroy
    @label = Label.find(params[:id])
    if @label.destroy
      redirect_to new_label_path, notice: "ラベル「#{@label.name}」を削除しました"
    else
      render :new
    end
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

  # def ensure_user
  #     @label = Label.find(params[:id])
  #     redirect_to tasks_path if @label.user != current_user
  #   end


end
