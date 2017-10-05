require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
    @my_topic = Topic.create!(title: Faker::Lorem.word, user: @my_user)
    @my_bookmark = Bookmark.create!(url: "tv.com", topic: @my_topic)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET index" do
    it "renders the index template" do
    get :index
      expect(response).to render_template("index")
    end
  end
end
