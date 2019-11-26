from selenium import webdriver
import selenium
import configparser

def before_all(context):
    context.alert = configparser.ConfigParser()
    context.element = configparser.ConfigParser()
    context.alert.read('model/alert.ini')
    context.element.read('model/element.ini')

def before_scenario(context, scenario):
    context.driver = webdriver.Chrome()
    context.driver.implicitly_wait(3)

def after_scenario(context, scenario):
    context.driver.quit()
