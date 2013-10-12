class Show < ActiveRecord::Base
  has_many :songs

  validates :title, presence: true, uniqueness: true
end

