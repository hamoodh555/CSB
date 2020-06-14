*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${baseurl}        https://csb.co.in/
${browser}        chrome

*** Test Cases ***
Logo and copy rights verification
    #Local browser launch
    Jenkins browser launch
    Element Should Be Visible    xpath=.//div[@class='navbar-brand']/a/img
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Text Should Be    xpath=.//div[@class='content']/p    ©2020 CSB Bank Ltd. All Rights Reserved
    Execute JavaScript    window.scrollTo(document.body.scrollHeight, 0)

header menu list and link redirection verification
    ${menu_list}=    Get Element Count    xpath=.//ul[@class='nav navbar-nav pad-top']/li[@class='dropdown mega-dropdown']
    Should Be True    ${menu_list}>=5

header and footer verification
    Element Should Be Visible    xpath=.//div[@id='header']
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Should Be Visible    xpath=.//div[@id='footer']

*** Keywords ***
Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${baseurl}
    Maximize Browser Window
    Set Browser Implicit Wait    15s
    Click Element    xpath=.//div[@id='closecovid']

Local browser launch
    Set Selenium Speed    1s
    Open Browser    ${baseurl}    ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    15s
    Click Element    xpath=.//div[@id='closecovid']
