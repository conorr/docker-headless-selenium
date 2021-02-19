import os
import logging
from selenium import webdriver

logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
logger = logging.getLogger(__file__)

DRIVER_PATH = "/bin/chromedriver"
DOWNLOAD_DIR = "/var/tmp/downloads"

def main():

    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")

    logger.info("Starting WebDriver")

    driver = webdriver.Chrome(DRIVER_PATH, options=options)

    driver.command_executor._commands["send_command"] = ("POST", '/session/$sessionId/chromium/send_command')
    params = {'cmd':'Page.setDownloadBehavior', 'params': {'behavior': 'allow', 'downloadPath': DOWNLOAD_DIR}}
    driver.execute("send_command", params)

    logger.info(f"Download directory set to {DOWNLOAD_DIR}")

    # Just to prove that it works
    test_url = 'https://www.duckduckgo.com'
    driver.get(test_url)
    logger.info(f"Got {test_url} with html length of {len(driver.page_source)}")

if __name__ == "__main__":
    main()