require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #downgrade" do
    it "returns http success" do
      get :downgrade
      expect(response).to have_http_status(:success)
    end
  end

end
