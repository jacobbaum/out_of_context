class Story < ActiveRecord::Base
  has_one :title
  has_one :quote
  has_one :attribution
end
