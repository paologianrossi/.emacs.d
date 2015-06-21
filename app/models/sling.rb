class Sling < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :brand
  has_many :specimens
  has_many :users, through: :specimens

  def color_list
    colors = self.colors || ""
    colors.split(",").map(&:strip).map(&:downcase)
  end

end
