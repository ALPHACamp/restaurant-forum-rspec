require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  it "login via email and password" do
    user = create(:user, email: '123@gmail.com', password: '123123')
    post "login", params: { email: user.email, password: '123123' }

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      'message' => 'ok',
      'auth_token' => user.authentication_token,
    })
  end

  it "login via facebook access_token" do
    user = create(:user, email: '123@gmail.com', password: '123123')
    fb_data = { "id" => "123", "email" => "123@gmail.com", "name" => "fung" }
    fb_access_token = 'blablabla'
    auth_hash = double('OmniAuth::AuthHash')
    allow(User).to receive(:get_facebook_user_data).with(fb_access_token).and_return(fb_data)

    allow(OmniAuth::AuthHash).to receive(:new).and_return(auth_hash)
    allow(User).to receive(:from_omniauth).with(auth_hash).and_return(user)

    post "login", params: { access_token: fb_access_token }

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      'message' => 'ok',
      'auth_token' => user.authentication_token
    })
  end

  it "logout succesfully" do
    user = create(:user, email: '123@gmail.com', password: '123123')
    token = user.authentication_token

    post "logout", params: { auth_token: user.authentication_token }

    expect(response).to have_http_status(200)
    user.reload
    expect(user.authentication_token).not_to eq(token)
  end
end
