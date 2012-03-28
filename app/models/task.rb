class Task
  include Mongoid::Document
  field :description
  field :done, type: Boolean
  
  validates_presence_of :description
end
