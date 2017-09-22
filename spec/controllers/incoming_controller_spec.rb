require 'rails_helper'

RSpec.describe IncomingController, type: :controller do
  describe "Get #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end
end
