class Api::V1::LessonsController < ApplicationController
  before_action :load_category
  before_action :load_category_lesson, only: [:show, :update, :destroy]

  def index
    render json: @category.lessons
  end

  def show
    render json: @lesson
  end

  def update
    if @lesson.update(lesson_params)
      render json: @lesson, status: :ok
    else
      render json: { message:"Update lesson failed" }, status: :bad
    end
  end

  def destroy
    if @lesson.destroy
      render json: { message:"Destroy lesson successfully" }, status: :ok
    else
      render json: { message:"Destroy lesson failed" }, status: :bad
    end
  end

  def create
    @category.lessons.create! lesson_params
    render json: @category, status: :created
  end

  private
  def lesson_params
    params.permit :name, :number_questions, :category_id
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    raise ActiveRecord::RecordNotFound unless @category
    @category
  end

  def load_category_lesson
    @lesson = @category.lessons.find_by!(id: params[:id]) if @category
    raise ActiveRecord::RecordNotFound unless @lesson
    @lesson
  end
end
