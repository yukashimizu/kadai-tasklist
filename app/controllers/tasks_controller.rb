class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order("created_at DESC").page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが投稿されました"
      redirect_to @task
    else
      flash[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to @task
    else
      flash[:danger] = "タスクを更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "タスクを削除しました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
    redirect_to root_url if @task.user != current_user
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
