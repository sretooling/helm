FROM alpine
LABEL project=sretooling author=david@starkers.com
RUN apk --update add wget
WORKDIR /src
ENV HELM_VER=2.12.3
RUN wget -L -c http://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VER}-linux-amd64.tar.gz -O helm.tgz
RUN tar xvf helm.tgz && chmod +x linux-amd64/helm


###
FROM alpine
RUN apk --update --upgrade add bash git py3-click py3-requests py3-yaml
COPY --from=0 /src/linux-amd64/helm /bin/.
RUN helm init --client-only && \
  helm plugin install https://github.com/chartmuseum/helm-push
COPY . /

