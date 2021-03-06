class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description
  field :done, type: Boolean
  field :deadline, type: Time
  field :order, type: Integer
  
  validates_presence_of :description
  validate :deadline_in_future?

  attr_accessible :description, :deadline, :done, :order

  private

  def deadline_in_future?
    if deadline
      errors.add(:deadline, "must be in the future.") unless deadline.future?
    end
  end
end
