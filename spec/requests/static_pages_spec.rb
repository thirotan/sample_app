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
#    it "should have response status equal 200 " do
#      get '/static_pages/home'
#      expect(response).to have_http_status(200)
#    end
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
end
