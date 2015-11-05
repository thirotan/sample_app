require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject { page }
  shared_examples_for "all static pages" do
    it { expect(page).to have_content(heading) }
    it { expect(page).to have_title(page_title) }
  end
  describe "GET /static_pages/home" do
    before {visit root_path}

    let(:heading) { 'Sample App' }
    let(:page_title) { "#{base_title} | Home" }
    it_behaves_like "all static pages"

    it { expect(page).not_to have_title('home') }

    describe "for signed_in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render ther user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { is_expected.to have_link("0 following", href: following_user_path(user)) }  
        it { is_expected.to have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "GET /static_pages/help" do
    before { visit help_path }
  
    let(:heading) { 'Help' }
    let(:page_title) { "#{base_title} | Help" }

    it_behaves_like "all static pages"
#    it "should have response status equal 200 " do
#      get  '/static_pages/help'
#      expect(response).to have_http_status(200)
#    end
  end

  describe "GET /static_pages/about" do
    before{ visit about_path }

    let(:heading) { 'Help' }
    let(:page_title) { "#{base_title} | About Us"}

    it_behaves_like "all static pages"
  end

  describe "GET /static_pages/contact" do
    before { visit contact_path }

    let(:heading) { 'Contact' }
    let(:page_title) { "#{base_title} | Contact" }

    it_behaves_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path 
    click_link "About"
    expect(page).to have_title(full_title("About Us"))
    click_link "Help"
    expect(page).to have_title(full_title("Help"))
    click_link "Contact"
    expect(page).to have_title(full_title("Contact"))
    click_link "Home"
    expect(page).to have_title(full_title("Home"))
    click_link "sample app"
    expect(page).to have_title(full_title("Home"))
  end 
end
