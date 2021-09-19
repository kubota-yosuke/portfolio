require 'rails_helper'

RSpec.describe "Matters", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/matters/index"
      expect(response).to have_http_status(:success)
    end
  end

end
