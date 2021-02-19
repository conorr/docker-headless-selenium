FROM python:3.8-slim

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y curl unzip

# Check available versions here: https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
ARG CHROME_VERSION="88.0.4324.182-1"
# Curl http://chromedriver.storage.googleapis.com/LATEST_RELEASE to see latest WebDriver release,
# but we are deliberately pinning to the following version
ARG VERSION="88.0.4324.96"
RUN curl -s -o /tmp/chrome.deb http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb
RUN apt install -y /tmp/chrome.deb
RUN rm /tmp/chrome.deb

# platform options: linux32, linux64, mac64, win32
ARG PLATFORM=linux64
RUN curl -s -o /var/tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$VERSION/chromedriver_$PLATFORM.zip
RUN unzip /var/tmp/chromedriver.zip -d /bin
#RUN chmod a+x /bin/chromedriver

# Install deps for chromedriver
#RUN apt-get install -y glib2.0 libnss3 libxcb1

RUN mkdir /var/tmp/downloads

COPY main.py .

ENV LOGLEVEL=INFO

CMD ["python", "main.py"]
