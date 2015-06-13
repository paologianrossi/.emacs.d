class Sling < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :brand

  def color_list
    colors = self.colors || ""
    colors.split(",").map(&:strip).map(&:downcase)
  end

end
