class UsersController < ApplicationController
  before_action :authentication, except: %i[create new]
  before_action :find_user, except: %i[create profile new]

  # GET /users/profile
  def show
    @current_user
  end

  def edit
    authorize! @user
    @current_user
  end

  def new
    @user = User.new
  end
  # POST /users
  def create
    user = User.new(user_params)
   if user.save
     token = encode_user_data({ user_id: user.id })
     redirect_to '/movies'
   else
     render json: { message: "invalid credentials" }
   end
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    authorize! @user
    if @user.update(user_update_params)
        redirect_to "/users/#{@current_user.id}"
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:username, :email).merge(password: BCrypt::Password.create(params[:user][:password]))
  end

  def user_update_params
    params.require(:user).permit(:username, :email)
  end
end
