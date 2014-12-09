require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

    # before :each do
      
    # end

  it "should get page for index" do
    
    get :index

    expect(response).to render_template(:index)
  end

 us

  # it "should get page for show" do
  #   get :show, FactoryGirl.attributes_for(:user2)

  #   expect(response).to render_template(:show)

  # end


 end
