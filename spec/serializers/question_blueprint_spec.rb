require 'rails_helper'

RSpec.describe QuestionBlueprint do
  describe '#render' do
    subject { JSON.parse(QuestionBlueprint.render(question)) }

    let!(:asker){ create(:user, name: 'Katrina Suarez') }
    let!(:question){ create(:question, title: "What is love?", user: asker) }
    let!(:answer){ create(:answer, question: question, body: 'Love is you, Katrina') }

    it 'should have the correct fields' do
      expect(subject.keys).to contain_exactly('title', 'id', 'user_name', 'private', 'answers')
    end

    it 'should have the correct field values' do
      expect(subject['title']).to eq "What is love?"
    end

    it 'should have answers' do
      expect(subject['answers']).not_to be_nil
      expect(subject['answers'].count).to eq 1
      expect(subject['answers'][0]['id']).to eq answer.id
    end
  end
end