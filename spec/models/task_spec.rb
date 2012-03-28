require 'spec_helper'

# Attributes
describe Task do
  it { should_not allow_mass_assignment_of(:creator) }
end
