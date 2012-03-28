class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description
  field :done, type: Boolean
  
  validates_presence_of :description
end
