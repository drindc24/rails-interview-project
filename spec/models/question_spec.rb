require 'rails_helper'

RSpec.describe Question do
  describe '#scopes' do
    context '#default_scope' do
      let!(:question_1){ create(:question) }
      let!(:question_2){ create(:question) }
      let!(:question_3){ create(:question) }
      let!(:question_4){ create(:private_question) }
      let!(:question_5){ create(:private_question) }

      it 'should not include private questions' do
        expect(Question.all).not_to include(question_4, question_5)
      end
    end
  end

  describe '#search' do
    let!(:question_1){ create(:question, title: 'Number one') }
    let!(:question_2){ create(:question, title: 'Number two') }
    let!(:question_3){ create(:question, title: 'Number three') }

    context 'has search query param' do
      subject { described_class.search('one') }

      it 'should return the appropriate question' do
        is_expected.to contain_exactly(question_1)
      end
    end

    context 'does not have search query param' do
      subject { described_class.search('') }

      it 'should return the appropriate question' do
        is_expected.to contain_exactly(question_1, question_2, question_3)
      end
    end
  end
end