class User < ActiveRecord::Base

  validates :email, email: true, presence: true
  validates :email, email: true, presence: true
  validates :gender, inclusion: { in: %w(male female), allow_blank: true }

  def self.from_omniauth(auth)
    create! do |user|
      user.provider=auth['provider']
      user.uid=auth['uid']
      info=auth['extra']['raw_info']
      user.name = info['name'] || ""
      user.first_name = info['first_name'] || ""
      user.last_name = info['last_name'] || ""
      user.email = info['email'] || ""
      user.gender = info['gender'] || ""
      user.link = info['link'] ||""
      user.locale = info['locale'] || "en_US"
      user.image_url = info['picture']['data']['url'] || ""
      user.significant_other_uid = info['significant_other_uid'] || ""
    end
  end

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end

  def significant_other
    self.class.find_by(uid: significant_other_uid)
  end
end
