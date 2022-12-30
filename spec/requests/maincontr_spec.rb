require 'rails_helper'

RSpec.describe "Maincontrs", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/maincontr/input"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/maincontr/show"
      expect(response).to have_http_status(:success)
    end
  end

end
