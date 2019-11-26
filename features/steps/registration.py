from behave import *
import time

@given('User is on last.fm website')
def step_impl(context):
    context.driver.get('https://www.last.fm/join')
    if context.driver.find_element_by_id('_evidon_banner').is_displayed():
        context.driver.find_element_by_id('_evidon-accept-button').click()
        context.driver.implicitly_wait(3)

@when('User fills "{field}" textbox with "{type}" {username} value')
def step_impl(context, field, type, username):
    context.driver.find_element_by_id(context.element[field]["id_"]).send_keys(username)

@when('User click on terms of use checkbox')
def step_impl(context):
    context.driver.find_element_by_id(context.element["terms_of_use"]["id_"])
    time.sleep(2)
    context.driver.find_element_by_id(context.element["terms_of_use"]["id_"]).click()

@when('User click on captcha container')
def step_impl(context):
    frame = context.driver.find_element_by_xpath(context.element["captcha"]["frame_xpath"])
    context.driver.switch_to.frame(frame)
    captcha = context.driver.find_element_by_id(context.element["captcha"]["container_id"])
    captcha.click()
    context.driver.switch_to.default_content()
    
@when('User click on submit button')
def step_impl(context):
    context.driver.find_element_by_xpath(context.element["submit"]["xpath"]).click()
    context.driver.implicitly_wait(3)

@then('User shall see captcha challange')
def step_impl(context):
    frame = context.driver.find_element_by_xpath(context.element["captcha"]["challange_frame_xpath"])
    time.sleep(3)
    assert frame.is_displayed() == True, "Captcha challange frame is not displayed !"

@then('User shall see alert about "{type}" "{field}"')
def step_impl(context, type, field):
    try:
        alert_content = context.driver.find_element_by_xpath(context.alert[field]["xpath"])
    except:
        assert False, "Alert is not displayed !"
    else:
        assert context.alert[field][type] in alert_content.text, "Wrong alert is displayed !"


