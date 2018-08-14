#!/usr/bin/env python3
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from pykeepass import PyKeePass as pkp
from urllib.parse import quote_plus

def get_password():
    with open("/home/vrybalko/.scripts/.env", "r") as f:
        dbpass = f.read()
    dbpass = dbpass.strip()
    kp = pkp('/home/vrybalko/gdrive/Passwords.kdbx', password=dbpass)
    entry = kp.find_entries(title='globallogic.com', first=True)
    return entry

def run_browser():
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--window-size=1920,1080")
    driver = webdriver.Firefox(firefox_options=options)
    entry = get_password()
    s = "https://" + quote_plus(entry.username) + ":" + quote_plus(entry.password) + "@portal-ua.globallogic.com/officetime/"
    driver.get(s)
    week_time = driver.find_element_by_id("daily_average").text.replace("h ", ":").replace("m", "")
    with open("/tmp/week_office_time", "w") as f:
        f.write(week_time)
    driver.close()

def main():
    run_browser()
    # get_password()

if __name__ == "__main__":
    main()
