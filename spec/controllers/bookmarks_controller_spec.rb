require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

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

    it "renders the show view" do
      get :show, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(response).to render_template :show
    end

    it "assigns @my_bookmark to @bookmark" do
      get :show, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(assigns(:bookmark)).to eq(@my_bookmark)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: @my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new, topic_id: @my_topic.id
      expect(response).to render_template :new
    end

    it "instantiates @bookmark" do
      get :new, topic_id: @my_topic.id
      expect(assigns(:bookmark)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Bookmark by 1" do
      expect{ post :create, topic_id: @my_topic.id, bookmark: {url: Faker::Internet.url}}.to change(Bookmark,:count).by(1)
    end

    it "assigns the new bookmark to @bookmark" do
      post :create, topic_id: @my_topic.id, bookmark: { url: Faker::Internet.url }
      expect(assigns(:bookmark)).to eq Bookmark.last
    end

    it "redirects the new bookmark to Topics index" do
      post :create, topic_id: @my_topic.id, bookmark: { url: Faker::Internet.url }
      expect(response).to redirect_to topic_path(@my_topic)
    end
  end

  describe "GET #edit" do
    it "returns http status success" do
      get :edit, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(response).to render_template :edit
    end

    it "assigns bookmark to be updated @bookmark" do
      get :edit, topic_id: @my_topic.id, id: @my_bookmark.id
      bookmark_instance = assigns(:bookmark)

      expect(bookmark_instance.id).to eq @my_bookmark.id
      expect(bookmark_instance.url).to eq @my_bookmark.url
    end
  end

  describe "PUT update" do
    it "updates bookmark with expected attributes" do
      new_url = Faker::Internet.url

      put :update, topic_id: @my_topic.id, id: @my_bookmark.id, bookmark: { url: new_url }

      updated_bookmark = assigns(:bookmark)
      expect(updated_bookmark.id).to eq @my_bookmark.id
      expect(updated_bookmark.url).to eq new_url
    end

    it "redirects to Topics index" do
      new_url = Faker::Internet.url

      put :update, topic_id: @my_topic.id, id: @my_bookmark.id, bookmark: { url: new_url }
      expect(response).to redirect_to topics_path
    end
  end

  describe "DELETE destroy" do
    it "deletes the bookmark" do
      delete :destroy, topic_id: @my_topic.id, id: @my_bookmark.id
      count = Bookmark.where({id: @my_bookmark.id}).size
      expect(count).to eq 0
    end

    it "redirects to the Topics index" do
      delete :destroy, topic_id: @my_topic.id, id: @my_bookmark.id
      expect(response).to redirect_to topics_path
    end
  end
end
