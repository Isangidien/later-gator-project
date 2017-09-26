require 'rails_helper'

RSpec.describe IncomingController, type: :controller do
#  describe "Get #create" do
#    it "returns http success" do
#      get :create
#      expect(response).to have_http_status(:success)
#    end
#  end
  before do
      @my_user = FactoryGirl.create(:user)
      sign_in @my_user
      @params = { 'sender': 'Jane Doe <someone@example.com>',
              'subject': 'tech crunch news 2017',
              'body-plain': 'http://www.techcrunch.com' }
  end

  it "should create a new bookmark" do
    expect{
      post :create, @params}.to change(Bookmark,:count).by(1)
  end
  it 'should create a new topic if it does not exist' do
    expect{
       post :create, @params}.to change(Topic,:count).by(1)
  end
end
