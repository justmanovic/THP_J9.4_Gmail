class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    puts "❤️"*60
    puts params
    puts "❤️"*60
    @task = Task.new(task_params)
    @category = Category.find(@task.category_id)
    @task.category = @category
    @categories = Category.all
    # @tasks = Task.all
    if @task.save
      flash[:notice] = "Task created"
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {}
      end
    else
      redirect_to root_path
      flash[:notice] = "Please try again"
    end


  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to tasks_path
    flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    puts params
    @task = Task.find(params[:id])
    @task.destroy
    @categories = Category.all
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :category_id)
  end
end
