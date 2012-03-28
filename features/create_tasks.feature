@javascript
Feature: Create Tasks
  In order not to forget something to do
  As a user, I want to create a task
  
  Scenario: Single task creation
    Given I am on the tasks page
    When I submit a new task
    Then I should see it on the top of the list
    And there should be 1 task saved
    And it should have the right info
    
  Scenario: Empty task
    Given I am on the tasks page
    When I submit an empty task
    Then I should see an error alert
    And there should be 0 tasks saved
  
  Scenario: Multiple tasks creation
    Given there are 5 tasks saved
    And I am on the tasks page
    When I submit a new task
    Then I should see it on the top of the list
    And there should be 6 tasks saved