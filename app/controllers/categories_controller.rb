class CategoriesController < ApplicationController
  before_action :authentication, except: %i[index search_movies]
  before_action :find_category, only: %i[search_movies edit update destroy]
  # GET /categories
  def index
    @categories = Category.all.order('name ASC')
  end

  def show
    @category
  end

  def new
    @category = Category.new
  end


  # GET /categories/:id/movies?page=:page
  def search_movies
    @movies = @category.movies.page(params[:page])

  end

  # POST /categories
  def create
    authorize!
    category = Category.new(category_params)
    if category.save
      redirect_to "/categories"
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def edit
    authorize!
    @category
  end
  # PATCH /categories/:id
  def update
    authorize! @category
    if @category.update(category_params)
      redirect_to "/categories"
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  #DEL /categories/:id
  def destroy
    authorize! @category
    @category.destroy
    redirect_to "/categories"
  end

  private
  def find_category
    @category = Category.find_by(id: params[:id])
  end
  def category_params
    params.require(:category).permit(:name)
  end
end
