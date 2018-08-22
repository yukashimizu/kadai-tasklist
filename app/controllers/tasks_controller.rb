class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクが投稿されました"
      redirect_to @task
    else
      flash[:danger] = "タスクが投稿されませんでした"
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to @task
    else
      flash[:danger] = "タスクを更新できませんでした"
      render :edit
    end
  end
end

def task_params
  params.require(:task).permit(:content)
end
