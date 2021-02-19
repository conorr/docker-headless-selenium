# docker-headless-selenium

A template for running headless Selenium in a container using ChromeDriver.

## Local setup

```
source local-setup.sh
```

## Build Docker image

```
docker build -t docker-headless-selenium .
```

## Run Docker image

```
docker run --rm docker-headless-selenium
```