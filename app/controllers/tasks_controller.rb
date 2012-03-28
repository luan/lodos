class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render json: { tasks: @tasks }
  end

  def show
    @task = Task.find(params[:id])
    render json: { task: @task }
  end

  def create
    @task = Task.new(params[:task])
    @task.save
    render json: { task: @task }
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    render json: { task: @task }
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render json: { task: @task }
  end
end
