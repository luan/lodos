@javascript
Feature: Create Tasks with deadlines
  In order not to lose deadlines
  As a user, I want to create a task with a deadline
  
  Scenario: Single task creation
    Given I am on the tasks page
    When I submit a new task with deadline
    Then I should see it on the top of the list
    And there should be 1 task saved
    And it should have the right info

