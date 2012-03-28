@javascript
Feature: Delete Tasks
  In order to remove tasks which are not tasks anymore
  As a user, I want to delete a task
  
  Scenario: Task deletion
    Given  there are 5 tasks saved
    And I am on the tasks page
    When I delete a task
    Then I should not see it on the list
    And there should be 4 task saved
    