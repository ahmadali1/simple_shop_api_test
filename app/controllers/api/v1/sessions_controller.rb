module Api
  module V1
    class SessionsController < ApiController
      include Authenticable

      before_action :authenticate!, only: [:show]

      # LOGGING IN
      def create
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
          token = encode_token({ user_id: @user.id })
          if token.nil?
            render json: { error: 'JWT encoding error.' }, status: :internal_server_error
            return
          end

          render json: { user: @user, token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
        end
      end

      def show
        render json: @user
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
