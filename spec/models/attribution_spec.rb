require 'rails_helper'

describe Attribution do

  let(:attribution) { FactoryGirl.create(:attribution) }

  subject { attribution }

  it { should respond_to(:text) }
  it { should respond_to(:altered_text) }

  it { should be_valid }

  describe 'validations' do
    describe 'text' do
      context 'not present' do
        before { attribution.text = nil }
        it { should_not be_valid }
      end
      context 'too long' do
        before { attribution.text = "John Doe, President of Partying" * 10 }
        it { should_not be_valid }
      end
    end
    describe 'altered_text' do
      context 'too long' do
        before { attribution.altered_text = "John Doe, President of Partying" * 10 }
        it { should_not be_valid }
      end
    end
  end
end