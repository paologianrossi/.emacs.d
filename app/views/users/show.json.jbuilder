fields = [:provider, :uid, :first_name, :last_name, :name, :email,
          :image_url, :gender, :link, :locale, :significant_other]
json.extract! @user, :id, *fields, :created_at, :updated_at
