module Api
  module V1
    class RegistrationsController < ApiController
      include Authenticable

      # REGISTER
      def create
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }, status: :created
        else
          render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotUnique => e
        render json: { error: 'An account with this email exists already.' }, status: :unprocessable_entity
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
