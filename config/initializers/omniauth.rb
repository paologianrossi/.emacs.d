Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret,
           info_fields: "birthday,email,first_name,gender,hometown,last_name,link,location,name,significant_other,timezone,website,picture,locale"

end
