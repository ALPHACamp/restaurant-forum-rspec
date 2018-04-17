require 'rails_helper'

RSpec.describe User, type: :model do
  it "should count all user" do
    expect(User.get_user_count).to eq(0)
    create(:user)
    expect(User.get_user_count).to eq(1)
  end

  it "should count all comments by this user" do
    user = create(:user)
    expect(user.get_comment_count).to eq(0)
    comment = create(:comment)
    user.comments << comment
    expect(user.get_comment_count).to eq(1)
  end

  it "should get_facebook_user_data work(webmock version)" do
    # need to replace ACCESS_TOKEN to you fb access token
    expect(User.get_facebook_user_data("ACCESS_TOKEN")).to eq({
      "id" => "FB_UID",
      "name" => "FB_NAME"
    })
  end
end
