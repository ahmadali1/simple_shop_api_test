module Authenticable
  extend ActiveSupport::Concern

  def log_exception(e)
    p '==============='
    p e
    p '==============='
  end

  included do
    def encode_token(payload)
      JWT.encode(payload, ENV.fetch('SECRET_KEY_BASE'))
    rescue JWT::EncodeError, KeyError => e
      log_exception e
      nil
    end

    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end

    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, ENV.fetch('SECRET_KEY_BASE'), true, algorithm: 'HS256')
        rescue JWT::DecodeError, KeyError => e
          log_exception e
          nil
        end
      end
    end

    def logged_in_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by(id: user_id)
      end
    end

    def logged_in?
      !logged_in_user.nil?
    end

    def authenticate!
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
  end
end
