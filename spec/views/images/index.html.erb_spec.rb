require 'spec_helper'

describe "images/index" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
    assign(:images, [
      FactoryGirl.create(:image, title: "Hoge"),
      FactoryGirl.create(:image, title: "Fuga")
    ])
  end
  it "renders a list of all images" do
    render
    assert_select "tr>td", :text => "Hoge".to_s, :count => 1
    assert_select "tr>td", :text => "Fuga".to_s, :count => 1
  end
end
