@javascript
Feature: Mark Tasks as done and see the progress
  In order to have a better idea of how much of the work is done
  As a user, I want to mark a task as done and have a progress bar tracking it
  
  Scenario: Mark task
    Given  there are 5 tasks saved
    And I am on the tasks page
    And there is a progressbar in 0%
    When I mark a task as done
    Then there should be a progressbar in 20%
    And there should be 1 task done
