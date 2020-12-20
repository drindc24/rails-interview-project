require 'rails_helper'

RSpec.describe AnswerBlueprint do
  describe '#render' do
    subject { JSON.parse(AnswerBlueprint.render(answer)) }

    let!(:question){ create(:question, title: 'What is your name?') }
    let!(:answerer){ create(:user, name: 'Klyde Andrei Dela Cruz') }
    let!(:answer){ create(:answer, user: answerer, question: question, body: 'My name is Klyde') }

    it 'should have the correct fields' do
      expect(subject.keys).to contain_exactly('id', 'question_id', 'user_name', 'body')
    end

    it 'should have the correct field values' do
      expect(subject['user_name']).to eq 'Klyde Andrei Dela Cruz'
      expect(subject['body']).to eq 'My name is Klyde'
    end
  end
end