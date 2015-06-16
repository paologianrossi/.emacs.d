module OmniAuth
  module Mock
    def mock_auth
      OmniAuth::AuthHash.new({
                               "provider"=>"facebook",
                               "uid"=>"12345",
                               "credentials" => {
                                 "token" => "mock_token",
                                 "secret" => "mock_secret"
                               },
                               "extra"=> {
                                 "raw_info" => {
                                   "email"=>"john_doe@example.com",
                                   "first_name" => "John",
                                   "gender" => "male",
                                   "last_name" => "Doe",
                                   "name" => "John Doe",
                                   "picture" => {
                                     "data" => {
                                       "url" =>  "http://example.com/picture"
                                     }},
                                   "significant_other" => {
                                     "id"=>"54321"
                                   },
                                   "timezone"=> 1
                                 }
                               }
                             })
    end

    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = mock_auth
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content "Subscribe with Facebook"
      auth_mock
      click_link "Subscribe with Facebook"
    end
  end
end
