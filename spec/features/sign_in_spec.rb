require "spec_helper"

describe "Signing in" do
  let!(:user){ User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

  before do
    visit '/'
    click_link 'Login'
  end

  describe "as a user without two factor authentication enabled" do
    it "doesn't interfere in the sign in process" do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      click_button login_button

      expect(page).to have_text('You are signed in')
    end
  end

  describe "as a user with to factor authentication enabled" do
    before do
      user.otp_required_for_login = true
      user.otp_secret = User.generate_otp_secret
      user.save!
    end

    describe "sad path" do
      describe "with invalid password" do
        it "fails" do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: '123'
          click_button login_button
          expect(page).to have_text('Invalid email or password')
        end
      end

      describe "with invalid OTP" do
        it "redirects user back to sign in page" do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          click_button login_button

          # ....
        end
      end
    end

    describe "happy path" do
      describe "with valid password & valid OTP" do

      end
    end
  end

end
