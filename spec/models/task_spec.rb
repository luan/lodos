require 'spec_helper'

describe Task do
  it { should validate_presence_of(:description) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:deadline) }
  it { should allow_mass_assignment_of(:done) }
  it { should allow_mass_assignment_of(:order) }
  
  it 'deadline is in the future' do
    Timecop.freeze
    task = Task.new description: 'Any description', deadline: 2.days.from_now
    task.should be_valid

    task = Task.new description: 'Any description', deadline: 2.days.ago
    task.should_not be_valid
  end
end
