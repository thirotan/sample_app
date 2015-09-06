require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages/home" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
    it "should have response status equal 200 " do
      get '/static_pages/home'
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /static_pages/helpe" do
    it "should have the content 'Help'" do 
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should have response status equal 200 " do
      get  '/static_pages/help'
      expect(response).to have_http_status(200)
    end
  end
end
