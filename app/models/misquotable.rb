class Misquotable < ActiveRecord::Base
  has_one :title
  has_one :quote
  has_one :attribution

  has_many :words, through: :token

  # has_many :words, through: :title, as: :token 
  # has_many :words, through: :quote, as: :token 
  # has_many :words, through: :attribution, as: :token 

  # has_many :words, through: :title  
  # has_many :words, through: :quote
  # has_many :words, through: :attribution

  # has_many :words, through: :title, source: :token, source_type: 'Title'  
  # has_many :words, through: :quote, source: :token, source_type: 'Quote'
  # has_many :words, through: :attribution, source: :token, source_type: 'Attribution'

  # has_many :words, :through => :attribution, :source => <name>.

  # :class_name, :class, :foreign_key, :validate, :autosave, :table_name, 
  # :before_add, :after_add, :before_remove, :after_remove, :extend, 
  # :primary_key, :dependent, :as, :through, :source, :source_type, 
  # :inverse_of, :counter_cache, :join_table, :foreign_type

end
