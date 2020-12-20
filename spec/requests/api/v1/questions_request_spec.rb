require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do
  describe '#index' do
    let!(:user){ create(:user) }
    let!(:question_1){ create(:question, user: user) }
    let!(:question_2){ create(:question, user: user, title: 'Question Two') }
    let!(:question_3){ create(:question, user: user, title: 'Question Three') }
    let!(:answer_1){ create(:answer, question: question_1) }
    let!(:answer_2){ create(:answer, question: question_1) }
    let!(:answer_3){ create(:answer, question: question_1) }
    let!(:answer_4){ create(:answer) }
    let!(:tenant){ create(:tenant) }
    let(:json_response){ JSON.parse(response.body) }

    describe 'has a valid tenant api key' do
      before do
        get '/api/v1/questions', params: { tenant_key: tenant.api_key }
        tenant.reload
      end

      it 'should have a success http status' do
        expect(response).to have_http_status :success
      end

      it 'should have the correct data' do
        expect(json_response[0]['title']).to eq question_1.title
        expect(json_response[0]['private']).not_to be_truthy
        expect(json_response[0]['user_name']).to eq user.name
        expect(json_response[0]['answers'].count).to eq 3
      end

      it 'should increment request count attr for tenant' do
        expect(tenant.request_count).to eq 1
      end
    end

    describe 'does not have a valid tenant api key' do
      before do
        get '/api/v1/questions', params: { tenant_key: '12345' }
      end

      it 'should have not have a success http status' do
        expect(response).to have_http_status :unauthorized
      end

      it 'should NOT increment request count attr for tenant' do
        expect(tenant.request_count).to eq 0
      end
    end

    describe 'does not have a tenant api key at all' do
      before do
        get '/api/v1/questions'
      end

      it 'should have not have a success http status' do
        expect(response).to have_http_status :unauthorized
      end

      it 'should NOT increment request count attr for tenant' do
        expect(tenant.request_count).to eq 0
      end
    end

    describe 'searching for a question' do
      before do
        get '/api/v1/questions', params: { search_q: 'Three', tenant_key: tenant.api_key }
      end

      it 'should have a success http status' do
        expect(response).to have_http_status :success
      end

      it 'should have the searched question data' do
        expect(json_response[0]['id']).to eq question_3.id
        expect(json_response[0]['title']).to eq question_3.title
      end
    end
  end
end