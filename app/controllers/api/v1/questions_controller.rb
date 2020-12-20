module Api
  module V1
    class QuestionsController < ActionController::API
      before_action :validate_api_key, only: [:index]
      after_action :increment_request_count, only: [:index]

      def index
        questions = Question.search(params[:search_q])
                            .page(params[:page])
        render json: QuestionBlueprint.render(questions), status: :ok
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

      def increment_request_count
        @tenant.increment!(:request_count) if @tenant
      end
    end
  end
end