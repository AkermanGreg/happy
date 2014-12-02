require 'rails_helper'

RSpec.describe User, :type => :model do

  before :each do
    @user = User.new(username: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it {should validate_presence_of(:username)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}


end
