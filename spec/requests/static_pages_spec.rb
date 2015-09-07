require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  describe "GET /static_pages/home" do
    before { visit '/static_pages/home' }
    it "should have the content 'Sample App'" do
      expect(page).to have_content('Sample App')
    end
    it "should have the right title" do
      expect(page).to have_title("#{base_title} | Home")
    end
#     it "should have response status equal 200 " do
#       get '/static_pages/home'
#       expect(response).to have_http_status(200)
#     end
  end

  describe "GET /static_pages/help" do
    before { visit '/static_pages/help '}
    it "should have the content 'Help'" do 
      expect(page).to have_content('Help')
    end
    it "should have the right title" do
      expect(page).to have_title("#{base_title} | Help")
    end
#    it "should have response status equal 200 " do
#      get  '/static_pages/help'
#      expect(response).to have_http_status(200)
#    end
  end

  describe "GET /static_pages/about" do
    before{ visit '/static_pages/about' }
    it "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end

    it "should have the right title" do
      expect(page).to have_title("#{base_title} | About Us")
    end
  end

  describe "GET /static_pages/contact" do
    before { visit '/static_pages/contact' }
    it "should hve the content 'Content'" do
      expect(page).to have_content('Contact')
    end
    
    it "should have the right title" do
      expect(page).to have_title("#{base_title} | Contact")
    end

  end
end
