@javascript
Feature: Edit Tasks
  In order to change a task after I created
  As a user, I want to edit a task
  
  Scenario: Task edition
    Given there are 1 task saved
    And I am on the tasks page
    When I click the edit button for a task
    And I edit the tasks info
    Then I should see it on the top of the list
    And it should have the right info
  