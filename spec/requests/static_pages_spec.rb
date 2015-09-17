require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject { page }
  describe "GET /static_pages/home" do
    before {visit root_path}
    it { expect(page).to have_content('Sample App') }
    it { expect(page).to have_title(full_title('Home')) }
#     it "should have response status equal 200 " do
#       get '/static_pages/home'
#       expect(response).to have_http_status(200)
#     end
  end

  describe "GET /static_pages/help" do
    before { visit help_path }
    it { expect(page).to have_content('Help') }
    it { expect(page).to have_title("#{base_title} | Help") }
#    it "should have response status equal 200 " do
#      get  '/static_pages/help'
#      expect(response).to have_http_status(200)
#    end
  end

  describe "GET /static_pages/about" do
    before{ visit about_path }
    it { expect(page).to have_content('About Us') }
    it { expect(page).to have_title("#{base_title} | About Us") }
  end

  describe "GET /static_pages/contact" do
    before { visit contact_path }
    it { expect(page).to have_content('Contact') }
    it { expect(page).to have_title("#{base_title} | Contact") }
  end
end
