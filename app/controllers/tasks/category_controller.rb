# frozen_string_literal: true

module Tasks
  # CategoryController Template
  class CategoryController < ApplicationController
    def index
      @categories = current_user.categories.all
    end

    def new
      @category = current_user.categories.new
    end

    def show
      @category = current_user.categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to categories_path, notice: "category doesn't exist"
    end

    def create
      @category = current_user.categories.new(category_params)

      # after category have been created continue to ask to create new category
      # give message that a category has been created
      if @category.save
        redirect_to category_new_path, notice: "successfully created #{@category[:name]} category"
      else
        render :new, status: :unprocessable_entity
      end
    rescue ArgumentError
      render :new, status: :unprocessable_entity
    end

    def edit
      @category = current_user.categories.find(params[:id])
    end

    def update
      @category = current_user.categories.find(params[:id])

      # if category has been found update
      # after update go to category list
      if @category.update(category_params)
        redirect_to categories_path, notice: 'successfully updated category'
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ArgumentError
      render :edit, status: :unprocessable_entity
    end

    def destroy
      # before deleting category, find then delete all tasks associated with it
      tasks = current_user.tasks.where(category_id: params[:id])
      tasks.delete_all unless tasks.length.zero?

      # if category has been found delete
      # after update go to category list
      @category = current_user.categories.find_by(id: params[:id])

      redirect_to categories_path, notice: "category doesn't exist" unless @category.present?

      @category.delete
      redirect_to categories_path, notice: "successfully deleted #{@category[:name]} category"
    end

    private

    def category_params
      params
        .require(:category)
        .permit(:name)
    end
  end
end
