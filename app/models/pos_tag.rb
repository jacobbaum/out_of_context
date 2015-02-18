class PosTag < ActiveRecord::Base
  has_many :words

  validates :tag, uniqueness: { case_sensitive: false }
end
