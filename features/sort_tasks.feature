@javascript
Feature: Sort Tasks
  In order to organize tasks in an order
  As a user, I want to be able to sort tasks out
  
  Scenario: Initial tasks
    Given there are 5 task saved with order
    And I am on the tasks page
    Then the top of the list should have the lower order

  Scenario: Sort tasks  
    Given there are 5 task saved with order
    And I am on the tasks page
    When I drag the last task to the top
    Then the top of the list should have the lower order
    And it should be the task that I dragged