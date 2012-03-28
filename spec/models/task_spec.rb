require 'spec_helper'

describe Task do
  it { should validate_presence_of(:description) }
  
  it 'deadline is in the future' do
    Timecop.freeze
    task = Task.new description: 'Any description', deadline: 2.days.from_now
    task.should be_valid

    task = Task.new description: 'Any description', deadline: 2.days.ago
    task.should_not be_valid
  end
end
