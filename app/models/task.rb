class Task
  include Mongoid::Document
  field :description
  
  validates_presence_of :description
end
