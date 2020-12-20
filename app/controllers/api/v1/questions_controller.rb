module Api
  module V1
    class QuestionsController < ActionController::API
      def index
        render json: QuestionBlueprint.render(Question.all), status: :ok
      end
    end
  end
end