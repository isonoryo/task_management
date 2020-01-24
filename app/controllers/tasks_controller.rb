class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :task_check, only: [:show]

  def index
    @task = current_user.tasks.created_at.page(params[:page]).per(5) #ログインユーザーのタスクを作成日降順に。created_atはモデルにスコープ記載。以下同様。
    if params[:sort_expired]
      @task = current_user.tasks.limit_at.page(params[:page]).per(5)
    end
    if params[:sort_priority]
      @task = current_user.tasks.priority_at.page(params[:page]).per(5)
    end
    if params[:title].present?
      @task = @task.search_title params[:title]
    end
    if params[:status].present?
      @task = @task.search_status params[:status]
    end
    if params[:label_id].present?#ラベル検索機能
      @task = @task.joins(:labels).where(labels: { id: params[:label_id] })
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private

    def task_params
      params.require(:task).permit(:title, :content, :limit, :status, :priority, :user_id, label_ids: [])
    end

    def set_task
    @task = Task.find(params[:id])
    end

    def task_check #他者の投稿へid指定で飛んだ場合でも、ユーザーとタスクのidをチェックして、閲覧不可にする。
      if @task.user_id != current_user.id
        redirect_to user_path(current_user.id), notice:"他者の投稿へはアクセス出来ません"
      end
    end

end
