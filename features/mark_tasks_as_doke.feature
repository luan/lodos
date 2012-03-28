@javascript
Feature: Mark Tasks as done
  In order to distinguish incomplete tasks from complete ones
  As a user, I want to delete a task
  As a user, I want to mark a task as done
  
  
  Scenario: Mark task
    Given  there are 5 tasks saved
    And I am on the tasks page
    When I mark a task as done
    Then I should see it strikethrough
    And there should be 1 task done
