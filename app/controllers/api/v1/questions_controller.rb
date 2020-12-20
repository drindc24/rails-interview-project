module Api
  module V1
    class QuestionsController < ActionController::API
      before_action :validate_api_key

      def index
        render json: QuestionBlueprint.render(Question.all), status: :ok
      end

      private

      def validate_api_key
        render_unauthorized('No tenant API key provided') and return unless params[:tenant_key]

        @tenant = Tenant.find_by(api_key: params[:tenant_key])

        render_unauthorized('API key is NOT valid') unless @tenant
      end

      def render_unauthorized(message)
        render json: { message: message }, status: :unauthorized
      end
    end
  end
end