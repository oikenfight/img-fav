require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
    assign(:my_images, [
      FactoryGirl.create(:image, title: "Hoge"),
      FactoryGirl.create(:image, title: "Fuga")
    ])
    assign(:fav_images, [
      FactoryGirl.create(:image, title: "HogeHoge"),
      FactoryGirl.create(:image, title: "FugaFuga")
    ])
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(@user.name)
  end
  it "renders a list of my-images " do
    render
    assert_select "tr>td", :text => "Hoge".to_s, :count => 1
    assert_select "tr>td", :text => "Fuga".to_s, :count => 1
  end
  it "renders a list of fav-images " do
    render
    assert_select "tr>td", :text => "HogeHoge".to_s, :count => 1
    assert_select "tr>td", :text => "FugaFuga".to_s, :count => 1
  end
end
