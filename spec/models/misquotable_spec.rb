require 'rails_helper'

describe Misquotable do

  let(:misquotable) { FactoryGirl.create(:misquotable) }

  subject { misquotable }

  it { should respond_to(:npr_id) }
  it { should respond_to(:link) }

  it { should be_valid }

  describe 'validations' do
    describe 'link' do
      context 'invalid format' do
        it 'is invalid' do
          invalid_links = %w{ link,com ttp:/site.biz dude@seriously.com 
                              link_dot_com #funzies }
          invalid_links.each do |link|
            misquotable.link = link
            expect(misquotable).to_not be_valid
          end
        end
      end
    end
  end
end


#     describe 'altered_text' do
#       context 'too long' do
#         before { misquotable.altered_text = "John Doe, President of Partying" * 10 }
#         it { should_not be_valid }
#       end
#     end
#   end
# end