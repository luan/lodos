class TasksController < ApplicationController
  before_filter :filter_nulls

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

  private

  def filter_nulls
    params[:task].each do |k, v|
      params[:task][k] = nil if v == 'null'
    end if params[:task]
  end
end
