require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject { page }
  describe "GET /users/new" do
    before {visit signup_path }
    it { expect(page).to have_content('Sign up') }
    it { expect(page).to have_title(full_title('Sign up')) }
  end
end
