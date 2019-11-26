# last_fm

Test scenarios for the registration form on [last.fm/join](https://last.fm/join) page. All test cases are  written in Behave language and automated in Python(3.7) and Selenium.

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install behave and selenium.

```sh
$ pip install -r requirements.txt
```


## Usage

For run single test scenario use command: behave -n "<scenario_name>"

Example:
```sh
$ behave -n "Validation wrong email addresses"
```


Run all test scenarios
```sh
$ behave
```

## Structure

Diagram presents repository folder tree with files

```sh
last_fm
|
│   behave.ini
│   chromedriver.exe
│   README.md
│   requirements.txt
│
├───features
│   │   environment.py
│   │   registration.feature
│   │
│   └───steps
│           registration.py
│
└───model
        alert.ini
        element.ini
```

## Notes

Validation wrong email addresses scenario detects wrong behaviour for:
- email@111.222.333.44444 - invalid IP format
- email@domain.web - .web is not a valid top level domain

Wrong behaviour observed also, with validation email address longer than 256 characters, example:
- [255 characters]@gmail.com - RFC 5321 states: The maximum total length of a reverse-path or forward-path is 256 characters.