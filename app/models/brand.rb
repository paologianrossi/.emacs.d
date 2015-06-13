class Brand < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :website, presence: true, format: URI::regexp(%w(http https)),
            uniqueness: { case_sensitive: false }

  has_many :slings

  before_validation ->{ self.website.downcase! if self.website }
end
