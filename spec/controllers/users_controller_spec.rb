require 'spec_helper'
require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe UsersController do
  describe "GET index" do
    it "assigns all users as @users" do
      user = FactoryGirl.create(:user)
      get :index
      expect(assigns(:users)).to match_array([user])
    end
  end
  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it "redirects to the created user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to user_path(assigns[:user])
      end
    end
  end
  describe "with invalid params" do
    it "assigns a newly created but unsaved user as @user"do
      expect{
        post :create, user: FactoryGirl.attributes_for(:user, name: nil)
      }.to_not change(User, :count)
    end
    it "re-renders the 'new' template" do
      post :create, user: FactoryGirl.attributes_for(:user, name: '')
      expect(response).to render_template :new
    end
  end
  context "login user" do
    before :each do
      @user = FactoryGirl.create(:user, name: "Fuga")
      session[:user_id] = @user.id
    end
    describe "GET show" do
      it "assigin the requested fav_images as @fav_images" do
        image = FactoryGirl.create(:image)
        favorite = FactoryGirl.create(:favorite, image: image, user: @user)
        get :show, id: @user, image: image
        expect(image.id).to eq favorite.image_id
      end
      it "assign the requested my_images as @my_images" do
        image = FactoryGirl.create(:image, user_id: @user.id)
        get :show, id:@user, image: image
        expect(image.user_id).to eq @user.id
      end
    end
    describe "GET edit" do
      it "assigns the requested user as @user" do
        get :edit, id: @user
        expect(assigns(:user)).to eq @user
      end
      it "does not assign the request usser as @user" do
        user = FactoryGirl.create(:user, id: @user.id+1)
        get :edit, id: user
        expect(response).to redirect_to user_url
      end
    end
    describe "DELETE destroy" do
      it "destroys the requested user" do
        expect{
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end
      it "does not destroy the requested user" do
        user = FactoryGirl.create(:user, id: @user.id+1)
        delete :destroy, id: user
        expect(response).to redirect_to user_url
      end
      it "redirects to the users list" do
        delete :destroy, id: @user
        expect(response).to redirect_to users_url
      end
    end
    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "Hoge")
          @user.reload
          expect(@user.name).to eq "Hoge"
        end
        it "redirects to the user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user)
          expect(response).to redirect_to @user
        end
      end
      describe "with invalid params" do
        it "assigns the user as @user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "")
          @user.reload
          expect(@user.name).to eq "Fuga"
        end
        it "re-renders the 'edit' template" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user, name: "")
          expect(response).to render_template :edit
        end
      end
    end
  end
  context 'logout user' do
    describe "GET edit" do
      it "redirects to login path" do
        user = FactoryGirl.create(:user)
        get :edit, id: user
        expect(response).to redirect_to sessions_login_path
      end
    end
    describe "DELETE destroy" do
      it "redirects to login path" do
        user = FactoryGirl.create(:user)
        delete :destroy, id: user
        expect(response).to redirect_to sessions_login_path
      end
    end
    describe "GET show" do
      it "redirect to users_path" do
        user = FactoryGirl.create(:user)
        get :show, id: user
        expect(response).to redirect_to users_path
      end
    end
  end
end
