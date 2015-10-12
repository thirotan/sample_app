require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  subject { page }
  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { is_expected.to have_title('Sign in') }
      #it { is_expected.to have_selector('div.alert.alert-danger', text: 'Invalid') }
      it { is_expected.to have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { is_expected.not_to have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it { is_expected.to have_title(user.name) }
      it { is_expected.to have_link('Users',       href: users_path)  }
      it { is_expected.to have_link('Profile',     href: user_path(user)) }
      it { is_expected.to have_link('Settings',    href: edit_user_path(user))}
      it { is_expected.to have_link('Sign out',    href: signout_path) }
      it { is_expected.not_to have_link('Sign in', href: signin_path) }
     
      describe "Followed by signout" do
        before { click_link "Sign out" }
        it { is_expected.to have_link('Sign in') }
      end
    end
  end
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { is_expected.to have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { is_expected.to have_title('Sign in') }
        end
      end

      describe "not exsists link" do
        before { visit root_path }

        it {  is_expected.not_to have_link('Profile',  href: user_path(user)) }
        it {  is_expected.not_to have_link('Settings', href: edit_user_path(user)) } 
        it {  is_expected.not_to have_link('Sign out', href: signout_path) }
        it {  is_expected.to have_link('Sign in',      href: signin_path ) }
      end
    end    

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the User#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#edit action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to( root_path ) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }

      before{ sign_in admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end

