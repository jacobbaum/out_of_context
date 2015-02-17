class Quote < ActiveRecord::Base
  belongs_to :misquotable
  has_many :words, as: :token
end
