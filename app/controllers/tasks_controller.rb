class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @task = Task.all.order(limit: :desc)
    elsif
      @task = Task.where("title LIKE ? AND status LIKE ?", "%#{ params[:title] }%", "%#{params[:status]}%")
    else params[:search]
      @task = Task.all.order(created_at: :desc)

      # @task = Task.search(params)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to new_task_path, notice: "🌟タスクを作成しました🌟"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "🌟タスクを編集しました🌟"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"🌟タスクを削除しました🌟"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

    def task_params
      params.require(:task).permit(:title, :content, :limit, :status)
    end

    def set_task
    @task = Task.find(params[:id])
    end

end
