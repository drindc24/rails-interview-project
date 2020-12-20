require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :routing do
  describe '#routing' do
    it { expect(get: '/api/v1/questions').to route_to(controller: 'api/v1/questions', action: 'index') }
  end
end