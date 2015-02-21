class Section < ActiveRecord::Base
  belongs_to :misquotable
  has_many :words

  validates :text, presence: true
end
