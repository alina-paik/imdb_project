class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:login]

  def new
    @session =  {}
  end

  def login
    user = User.find_by(email: params[:email])

    if user && BCrypt::Password.new(user.password) == params[:password]

      token = encode_user_data(user_id: user.id)
      response.set_cookie(
        :session,
        value: token,
        expires: 1.year.from_now,
        domain: (ENV["HEROKU_APP_NAME"] || "localhost"),
        path: "/",
        secure: Rails.env.production?,
        httponly: Rails.env.production?
      )
      redirect_to '/movies'
    else
      render json: { message: 'invalid credentials' }
    end
  end

  def logout
    response.delete_cookie(:session, domain: (ENV["HEROKU_APP_NAME"] || 'localhost'), path: "/")
    redirect_to '/movies'
  end
end
