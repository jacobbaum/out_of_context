class Word < ActiveRecord::Base
  belongs_to :token, polymorphic: true
  belongs_to :pos_tag

end
