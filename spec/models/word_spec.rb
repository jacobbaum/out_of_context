require 'rails_helper'

describe Word do

  let(:word) { FactoryGirl.create(:word) }

  subject { word }

  it { should respond_to(:text) }
  it { should respond_to(:replacement) }
  it { should respond_to(:replace?) }
  it { should respond_to(:repeat?) }

  it { should be_valid }

  describe 'validations' do
    describe 'text' do
      context 'not present' do
        before { word.text = nil }
        it { should_not be_valid }
      end
      context 'too long' do
        before { word.text = "loremerol" * 10 }
        it { should_not be_valid }
      end
    end
    describe 'replacement' do
      context 'too long' do
        before { word.replacement = "loremerol" * 10 }
        it { should_not be_valid }
      end
    end
  end
end