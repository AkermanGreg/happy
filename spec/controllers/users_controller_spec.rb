require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

    # before :each do
      
    # end

  it "should get page for index" do
    
    get :index

    expect(response).to render_template(:index)
  end

  it "should save user if getting created" do
    
    post :create, user: FactoryGirl.attributes_for(:user)

    expect(response).to redirect_to(root_url)
  end

  # it "should get page for show" do
  #   get :show, FactoryGirl.attributes_for(:user2)

  #   expect(response).to render_template(:show)

  # end


 end
