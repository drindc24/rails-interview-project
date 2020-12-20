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
end