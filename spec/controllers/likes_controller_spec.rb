require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before do
    @my_user = FactoryGirl.create(:user)
    sign_in @my_user
    @my_topic = Topic.create!(title: Faker::Lorem.word, user: @my_user)
    @my_bookmark = Bookmark.create!(url: "tv.com", topic: @my_topic)
  end

  describe "POST create" do
    it "redirects to the bookmarks topic" do
      post :create, { bookmark_id: @my_bookmark.id }
      expect(response).to redirect_to(@my_topic)
    end
    it "creates a like for the current user and specified bookmark" do
      expect(@my_user.likes.find_by_bookmark_id(@my_bookmark.id)).to be_nil
      post :create, { bookmark_id: @my_bookmark.id}
    end
  end

  describe "DELETE destroy" do
    it "redirects to the bookmark show view" do
      like = @my_user.likes.where(bookmark: @my_bookmark).create
      delete :destroy, { bookmark_id: @my_bookmark.id, id: like.id }
      expect(response).to redirect_to(@my_topic)
    end
    it "destroys the like for the current user and specified bookmark" do
      like = @my_user.likes.where(bookmark: @my_bookmark).create
      expect( @my_user.likes.find_by_bookmark_id(@my_bookmark.id)).not_to be_nil
      delete :destroy, { bookmark_id: @my_bookmark.id, id: like.id}
      expect(@my_user.likes.find_by_bookmark_id(@my_bookmark.id)).to be_nil
    end
  end
end
