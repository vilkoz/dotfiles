#!/usr/bin/env python3
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from pykeepass import PyKeePass as pkp
from urllib.parse import quote_plus
from subprocess import check_output
from subprocess import CalledProcessError

def get_password():
    with open("/home/vrybalko/.scripts/.env", "r") as f:
        dbpass = f.read()
    dbpass = dbpass.strip()
    kp = pkp('/home/vrybalko/Passwords.kdbx', password=dbpass)
    entry = kp.find_entries(title='globallogic.com', first=True)
    return entry

def run_browser():
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--window-size=1920,1080")
    # print("start driver open")
    # driver = webdriver.Firefox(firefox_options=options)
    driver = webdriver.Chrome(options=options)
    # print("driver openned")
    entry = get_password()
    # print("got password")
    s = "https://" + quote_plus(entry.username) + ":" + quote_plus(entry.password) + "@portal-ua.globallogic.com/officetime/"
    driver.get(s)
    # print("loaded page")
    week_time = driver.find_element_by_id("daily_average").text
    if week_time:
        week_time = week_time.replace("h ", ":").replace("m", "")
    else:
        week_time = "error"

    table_view_button = driver.find_element_by_css_selector("a.btn-right:nth-child(7)")
    table_view_button.click()
    ths = driver.find_elements_by_css_selector(".totalforday > .th.td3")[-1].text

    week_time += " " + ths

    with open("/tmp/week_office_time", "w") as f:
        f.write(week_time)
    driver.close()

def kill_browser():
    # check_output("fish -c \"for n in (ps aux | grep firefox | grep headless | awk '{print $2}'); kill -9 $n; end\"", shell=True)
    try:
        check_output("killall chromium-browser", shell=True)
    except CalledProcessError:
        pass

def main():
    run_browser()
    kill_browser()
    # get_password()

if __name__ == "__main__":
    main()
