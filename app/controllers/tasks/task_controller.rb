# frozen_string_literal: true

module Tasks
  # TaskController Template
  class TaskController < ApplicationController
    def index
      @tasks = Task.all
    end

    def show
      # if task doesn't exist go to task list
      # show message that it doesn't exist
      task = current_user.tasks.find_by(id: params[:id])
      if task.present?
        @task = current_user.tasks.find(params[:id])
        @category = @task.category
      else
        redirect_to tasks_path, alert: "task doesn't exist"
      end
    end

    def new
      @task = Task.new
      @categories = current_user.categories.all.order(name: :asc)
    end

    def create
      # check user input if enter valid number that can be converted to hours
      hour = task_params[:hours].match(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/)

      # if not valid nu,ber for hour just ask again for new task
      if hour.nil?
        redirect_to task_new_path, notice: 'invalid time'
        return
      end

      name = task_params[:name]
      description = task_params[:description]
      deadline = (DateTime.now + task_params[:hours].to_d.hour)
      category_id = task_params[:category]

      if category_id == ''
        redirect_to task_new_path, notice: 'please enter valid category'
        return
      end

      # create new task based on category
      @task = current_user.tasks.new(name:, description:, deadline:, category_id:)

      # if task successfully save ask to enter another task
      if @task.save
        redirect_to task_new_path, notice: 'successfully created a task'
      else
        render :new, status: :unprocessable_entity
      end
    rescue ActionView::Template::Error
      redirect_to task_new_path, notice: 'please enter valid inputs'
    rescue ActionController::ParameterMissing
      redirect_to task_new_path, notice: 'please enter valid inputs'
    end

    def edit
      @task = current_user.tasks.find(params[:id])
      @categories = Category.all.order(name: :asc)
    end

    def update
      @task = current_user.tasks.find(params[:id])

      # check user input if enter valid number that can be converted to hours
      hour = task_params[:hours].match(/\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/)

      # if not valid nu,ber for hour just ask again for new task
      if hour.nil?
        redirect_to task_edit_path(@task), notice: 'invalid time'
        return
      end

      name = task_params[:name]
      description = task_params[:description]
      category_id = task_params[:category]
      deadline = (DateTime.now + task_params[:hours].to_d.hour)

      if category_id == ''
        redirect_to task_edit_path, notice: 'please enter valid category'
        return end

      # update task based on category
      # if task successfully updated go to task list
      if @task.update(name:, description:, deadline:, category_id:)
        redirect_to tasks_path, notice: 'successfully updated task'
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ActionView::Template::Error
      redirect_to task_edit_path(@task), notice: 'please enter valid inputs'
    rescue ActionController::ParameterMissing
      redirect_to task_edit_path(@task), notice: 'please enter valid inputs'
    end

    def destroy
      # if task has been found delete
      # after delete go to task list
      @task = current_user.tasks.find_by(id: params[:id])

      redirect_to tasks_path, notice: "category doesn't exist" unless @task.present?

      @task.delete
      redirect_to tasks_path, notice: "successfully deleted #{@task[:name]} task"
    end

    private

    def task_params
      params
        .require(:task)
        .permit(:name, :description, :hours, :category)
    end
  end
end
