class Word < ActiveRecord::Base
  belongs_to :token, polymorphic: true
  belongs_to :pos_tag

  # The longest word in the English language has 45 letters
  validates :text, presence: true, length: { maximum: 50 }
  validates :replacement, length: { maximum: 50 }
end
