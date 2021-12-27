module Api
  module V1
    class ApiController < ApplicationController
      include Authenticable
      before_action :set_default_format
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def record_not_found
        render json: { errors: 'Resource not found' }, status: :not_found
      end

      private

      def set_default_format
        request.format = :json
      end
    end
  end
end
