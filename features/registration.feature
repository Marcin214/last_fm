Feature: Registration
  As a user I want to create
  new account to join Last.fm

  Scenario: Submission blank registration form
       Given User is on last.fm website
        When User click on submit button
        Then User shall see alert about "blank" "username"
        And User shall see alert about "blank" "email"
        And User shall see alert about "blank" "password"
        And User shall see alert about "blank" "confirm_password"
        And User shall see alert about "blank" "terms_of_use"
        And User shall see alert about "blank" "captcha"


  Scenario Outline: Validation wrong email addresses
    Given User is on last.fm website
    When User fills "email" textbox with "invalid" <email> value
    Then User shall see alert about "invalid" "email"

    Examples: Wrong email addresses
      | email                        |
      | plainaddress                 |
      | #@%^%#$@#$@#.com             |
      | @domain.com                  |
      | Joe Smith <email@domain.com> |
      | email.domain.com             |
      | email@domain@domain.com      |
      | .email@domain.com            |
      | email.@domain.com            |
      | email..email@domain.com      |
      | あいうえお@domain.com         |
      | email@domain.com(Joe Smith)  |
      | email@domain                 |
      | email@-domain.com            |
      | email@domain.web             |
      | email@111.222.333.44444      |
      | email@domain..com            |


  Scenario Outline: Validation correct email addresses
    Given User is on last.fm website
    When User fills "email" textbox with "valid" <email> value
    Then User shall see alert about "valid" "email"

    Examples: Correct email addresses
      | email                         |
      | email@domain.com              |
      | firstname.lastname@domain.com |
      | email@subdomain.domain.com    |
      | firstname+lastname@domain.com |
      | email@123.123.123.123         |
      | email@[123.123.123.123]       |
      | "email"@domain.com            |
      | 1234567890@domain.com         |
      | email@domain-one.com          |
      | _______@domain.com            |
      | email@domain.name             |
      | email@domain.co.jp            |
      | firstname-lastname@domain.com |


   Scenario Outline: Registration with invalid username
     Given User is on last.fm website
      When User fills "username" textbox with "invalid" <username> value
      And User fills "email" textbox with "valid" <email> value
      And User fills "password" textbox with "valid" <password> value
      And User fills "confirm_password" textbox with "valid" <password_conf> value
      And User click on terms of use checkbox
      And User click on captcha container
      Then User shall see captcha challange
      And User shall see alert about "invalid" "username"
      And User shall see alert about "valid" "email"
      And User shall see alert about "valid" "password"
      And User shall see alert about "valid" "confirm_password"

    Examples: Invalid username, assumed that e-mail exists and was not used before
      | username                  | email                  | password     | password_conf |
      | h                         | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |
      | heelloo32145heel          | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |
      | heelloo  32145            | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |
      | =heelloo32145             | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |
      | heelloo32145)             | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |


   Scenario Outline: Registration with consistent but invalid passwords
     Given User is on last.fm website
      When User fills "username" textbox with "valid" <username> value
      And User fills "email" textbox with "valid" <email> value
      And User fills "password" textbox with "invalid" <password> value
      And User fills "confirm_password" textbox with "invalid" <password_conf> value
      And User click on terms of use checkbox
      And User click on captcha container
      Then User shall see captcha challange
      And User shall see alert about "valid" "username"
      And User shall see alert about "valid" "email"
      And User shall see alert about "invalid" "password"
      And User shall see alert about "invalid" "confirm_password"

    Examples: Invalid but consistent passwords
      | username       | email                  | password                 | password_conf               |
      | heelloo32145   | heelloo32145@gmail.com | hol1_                    | hol1_                       |
      | heelloo32145   | heelloo32145@gmail.com | heelloo00                | heelloo00                   |
      | heelloo32145   | heelloo32145@gmail.com | 123456789                | 123456789                   |
      | heelloo32145   | heelloo32145@gmail.com | 123456789@#              | 123456789@#                 |
      | heelloo32145   | heelloo32145@gmail.com | !"#$%&'()*+,-./:;<=>?@[  | !"#$%&'()*+,-./:;<=>?@[     |
      | heelloo32145   | heelloo32145@gmail.com | heellooheelloo           | heellooheelloo              |
      | heelloo32145   | heelloo32145@gmail.com | heellooheelloo>?@[       | heellooheelloo>?@[          |


  Scenario Outline: Registration with valid passwords but wrong confirmation
    Given User is on last.fm website
    When User fills "username" textbox with "valid" <username> value
    And User fills "email" textbox with "valid" <email> value
    And User fills "password" textbox with "valid" <password> value
    And User fills "confirm_password" textbox with "not_match" <password_conf> value
    And User click on terms of use checkbox
    And User click on captcha container
    Then User shall see captcha challange
    And User shall see alert about "valid" "username"
    And User shall see alert about "valid" "email"
    And User shall see alert about "valid" "password"
    And User shall see alert about "not_match" "confirm_password"

    Examples: Valid passwords and wrong confirmation
      | username     | email                  | password  | password_conf |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | heelloo1      |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | heello1_      |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | heelloo_      |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | heelloo1_@#   |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | heelloo1-     |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | HEELLOO1_     |
      | heelloo32145 | heelloo32145@gmail.com | heelloo1_ | hEelloo1_     |


Scenario Outline: Registration with valid parameters, but withou captcha
   Given User is on last.fm website
    When User fills "username" textbox with "valid" <username> value
    And User fills "email" textbox with "valid" <email> value
    And User fills "password" textbox with "valid" <password> value
    And User fills "confirm_password" textbox with "valid" <password_conf> value
    And User click on terms of use checkbox
    And User click on submit button
    Then User shall see alert about "blank" "captcha"

  Examples: Valid parameters
    | username                  | email                  | password     | password_conf |
    | heelloo32145              | heelloo32145@gmail.com | heelloo1_    | heelloo1_     |