require 'rails_helper'

describe Title do

  let(:title) { FactoryGirl.create(:title) }

  subject { title }

  it { should respond_to(:text) }
  it { should respond_to(:altered_text) }

  it { should be_valid }

  describe 'validations' do
    describe 'text' do
      context 'not present' do
        before { title.text = nil }
        it { should_not be_valid }
      end
      context 'too long' do
        before { title.text = "Crazy News is Happening" * 12 }
        it { should_not be_valid }
      end
    end
    describe 'altered_text' do
      context 'too long' do
        before { title.altered_text = "Crazy News is Happening" * 12 }
        it { should_not be_valid }
      end
    end
  end
end