# Feature: sign in
#  As a: User
#  I want to: sign in
#  So that: I can visit restricted areas of the site

feature "Sign in", :omniauth do
  scenario "user can sign in with valid account" do
    signin
    expect(page).to have_content("Logout")
  end

  scenario "user cannot sign in with invalid account" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit root_path
    expect(page).to have_content("Subscribe with Facebook")
    click_link "Subscribe with Facebook"
    expect(page).to have_content('Subscribe with Facebook')
  end
end
