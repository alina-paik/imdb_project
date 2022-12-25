class MoviesController < ApplicationController
  before_action :authentication, except: %i[index show]
  before_action :find_movie, except: %i[index create]

  # GET /movies?page=:page
   def index
     @movies = Movie.page(params[:page])
   end

   # GET /movies/:id
   def show
     @movie
     @categories = @movie.categories
   end

   def new
     @movie = Movie.new
     categories = Category.all
     @categories_mapping = Hash.new.tap do |hash|
        categories.each { |category| hash[category.name] = category.id}
     end
   end

   def edit
     authorize!
     @movie
   end

  # POST /movies
  def create
    authorize!
    @movie = Movie.new(movie_params)

    params["movie"]["categories"].each do |category_id|
      if category_id.present?
        category = Category.find(category_id)
        @movie.categories << category
      end
    end
    save_movie
  end

  # PATCH /movies/:id
  def update
    authorize! @movie
    if @movie.update(movie_params)
      redirect_to "/movies/#{@movie.id}"
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  #DEL /movies/:id
  def destroy
    authorize! @movie
    @movie.destroy
    redirect_to "/movies"
  end

  # POST movies/:id/categories
  def add_category
    authorize! @movie
    find_category
    if @categories_ids.include?(params[:category_id])
      render json: { message: 'category is present' }
    elsif (category = Category.find_by(id: params[:category_id])).present?
      @movie.categories << category
      save_movie
    else
      render json: { message: 'category not found' }
    end
  end

  # DEL movies/:id/categories
  def remove_category
    authorize! @movie
    find_category
    category = Category.find_by(id: params[:category_id])
    if @categories_ids.include?(params[:category_id])
      @movie.categories.delete(category)
      render json: @movie, status: :ok
    else
      render json: { message: 'category not found' }
    end
  end

  # POST movies/:id/rating
  def rate_movie
    rate = Rating.new(rating_params)
    if rate.save
      render json: rate, status: :created
    else
      render json: rate.errors, status: :unprocessable_entity
    end
  end


  private
  def find_movie
    @movie = Movie.find_by(id: params[:id])
  end
  def movie_params
    params.require(:movie).permit(:title, :title_image, :description)
  end

  def save_movie
    if @movie.save
      redirect_to "/movies/#{@movie.id}"
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def find_category
   @categories_ids = @movie.categories.map(&:id)
 end

 def rating_params
   params.require(:rating).permit(:grade, :movie_id).merge(user_id: current_user.id)
 end
end
