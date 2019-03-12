class Api::V1::CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def index
    @categories = Category.all
    render json: @categories, status: :ok
  end

  def show
    render json: @category
  end

  private
  def category_params
    params.permit(:name, :description, :parent_id)
  end

  def load_category
    @category = Category.find(params[:id])
  end
end
