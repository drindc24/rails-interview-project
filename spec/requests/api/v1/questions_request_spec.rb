require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do
  describe '#index' do
    let!(:user){ create(:user) }
    let!(:question){ create(:question, user: user) }
    let!(:answer_1){ create(:answer, question: question) }
    let!(:answer_2){ create(:answer, question: question) }
    let!(:answer_3){ create(:answer, question: question) }
    let!(:answer_4){ create(:answer) }
    let(:json_response){ JSON.parse(response.body) }

    before do
      get '/api/v1/questions'
    end

    it 'should have a success http status' do
      expect(response).to have_http_status :success
    end

    it 'should have the correct data' do
      expect(json_response[0]['title']).to eq question.title
      expect(json_response[0]['private']).not_to be_truthy
      expect(json_response[0]['user_name']).to eq user.name
      expect(json_response[0]['answers'].count).to eq 3
    end
  end
end