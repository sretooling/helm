FROM alpine
LABEL project=sretooling author=david@starkers.com
RUN apk --update add wget
WORKDIR /src
ENV HELM_VER=2.12.3
RUN wget -L -c http://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VER}-linux-amd64.tar.gz -O helm.tgz
RUN tar xvf helm.tgz && chmod +x linux-amd64/helm


###
FROM python:3-alpine
ENV PYTHONUNBUFFERED=1
RUN apk --update --upgrade add bash git
COPY requirements.txt /
RUN pip3 install -r requirements.txt
COPY --from=0 /src/linux-amd64/helm /bin/.
RUN helm init --client-only && \
  helm plugin install https://github.com/chartmuseum/helm-push
COPY . /
