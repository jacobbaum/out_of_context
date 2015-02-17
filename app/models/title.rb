class Title < ActiveRecord::Base
  belongs_to :misquotable
  has_many :words, as: :token
end
