class ApplicationController < ActionController::Base
  include ActionPolicy::Controller
  before_action :set_session
  authorize :user, through: :current_user

  SECRET="yoursecretword" # move to .env

  attr_reader :current_user

  def set_session
    decode_data = decode_user_data(request.cookies['session'])
    user_id = decode_data[0]['user_id'] if decode_data
    @current_user = User.find(user_id) if user_id
  end

  def authentication
    if @current_user
      true
    else
      render json: { message: 'user is unauthorized' }, status: :unauthorized
    end
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, true, algorithm: 'HS256'
  rescue StandardError => e
    puts e
  end
end
