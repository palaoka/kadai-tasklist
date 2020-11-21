class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :update, :destroy, :show]
    before_action :set_task, only: [:edit, :update, :destroy, :show]
    
    def index
        @task = current_user.tasks.build  # form_with 用
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    
    def show
    end
    
    
    def create
      #@task = current_user.tasks.build(task_params)
      @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に投稿されました"
            redirect_to root_url
        else
            flash.now[:danger] = "Taskが投稿されませんでした"
            render :new
        end
    end
    
    def new
        @task = current_user.tasks.build
    end
    
    def edit
    end
    
    def update
        @task = current_user.tasks.find_by(id: params[:id])
        if @task.update(task_params)
            flash[:success] = "タスクは正常に更新されました"
            redirect_to root_url
        else
            flash.now[:danger] = "タスクは更新されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskは正常に削除されました"
        redirect_to root_url
    end
    
    private
    
    def set_task
        @task = current_user.tasks.find_by(id: params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
        redirect_to root_url
        end
    end
end