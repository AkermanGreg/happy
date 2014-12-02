require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  it "should get page for index" do

    get :index

    expect(response).to be_success
    expect(response).to have_http_status(200)

  end

  it "should get page for show" do

    get :show

    expect(response).to be_success
    expect(response).to have_http_status(200)

  end


 end
