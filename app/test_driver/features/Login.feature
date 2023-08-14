Feature: Main Screen Validates and the Logs In
    Scenario: email and password are correct and login is clicked
        Given I have "email_form" and "password_form" and "signInButton"
        When I fill the "email_form" field with "teste@gmail.com"
        And I fill the "password_form" field with "teste1"
        Then I tap the "signInButton" button
        Then I should have "home_page" on screen