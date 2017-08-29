require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do

      end

      it "validates that the password is at least 6 characters long" do

      end
    end

    context "with valid params" do
      before do
        post :create, params: { user: {email: Faker::Internet.email, password: '123456'} }
      end

      it "logs the user in" do
        expect(session[:session_token]).to eq(User.last.session_token)
      end

      it "redirects user to bands index on success" do
        expect(response).to redirect_to(bands_url)
      end
    end
  end
end
