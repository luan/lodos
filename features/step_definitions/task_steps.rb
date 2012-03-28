$task_description = 'Gorgeous task!'
$task_deadline = nil

def submit_task(description, deadline=nil)
  within '#task' do
    fill_in 'description', with: description
    fill_in 'deadline', with: deadline if deadline
    click_button 'Add Task'
  end
end

Given /^I am on the tasks page$/ do
  visit '/'
end

When /^I submit a new task$/ do
  submit_task $task_description
end

When /^I submit a new task with deadline$/ do
  $task_deadline = Time.new *'2012-10-01 20:30'.split(/[^0-9]/)
  submit_task $task_description, $task_deadline
end

When /^I submit an empty task$/ do
  submit_task ''
end

Then /^I should see it on the top of the list$/ do
  find('#tasks').should have_content(Task.last.description)
end

Given /^there are (\d+) tasks saved$/ do |count|
  count = count.to_i
  count.times do |i|
    Task.create description: "Task #{i + 1}"
  end
end

Then /^there should be (\d+) tasks? saved$/ do |count|
  count = count.to_i
  Task.count.should eq(count)
end

Then /^it should have the right info$/ do
  Task.last.description.should eq($task_description)
  Task.last.deadline.should eq($task_deadline)
end

Then /^I should see an error alert$/ do
  page.should have_selector('.alert-error')
end

When /^I delete a task$/ do
  find('#tasks').first('.delete .delete').click
end

Then /^I should not see it on the list$/ do
  find('#tasks').should_not have_content('Task 5')
end

When /^I mark a task as done$/ do
  find('#tasks').first('input[type="checkbox"]').set(true)
end

Then /^I should see it strikethrough$/ do
  find('#tasks').should have_selector('.done')
end

Then /^there should be (\d+) task done$/ do |count|
  count = count.to_i
  Task.where(done: true).count.should eq(count)
end