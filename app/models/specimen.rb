class Specimen < ActiveRecord::Base
  belongs_to :user
  belongs_to :sling

  validates :user, presence: true
  validates :sling, presence: true
end
