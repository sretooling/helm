[![Build Status](https://travis-ci.org/sretooling/helm.svg?branch=master)](https://travis-ci.org/sretooling/helm)

# helm
Container with some helpers for 'helm' related tasks

**TL;RD**: contains scripts and binaries such as:
- helm push (plugin)
- helm linting
- scripts to make pushing to a chart museum easier


# Usage

- it will use a py script to determine if your local chart is published
- if *not* it will attempt to publish it to chart museum


you need to have some ENV vars set.. namely:
```
export HELM_REPO_HOST=https://chartmuseum.example.com
export HELM_REPO_USER=basic-username
export HELM_REPO_PASS=mypassword
./chart-push ./mycharts/*
```


Example gitlab-ci stage:

```
# publish the helm chart if needed
# don't forget the ENV VARs
chart-push:
  stage: helm
  only:
    - master
  image: sretooling/helm:latest
  script:
    - /chart-pusher ./charts/*
```
