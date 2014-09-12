require "spec_helper"

describe "Registration" do

  it "doesn't interfere with regular registration process" do
    visit '/users/sign_up'

    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_text('You are signed in')

    click_link 'Logout'
    expect(page).to have_text('You are not signed in')
  end

end
