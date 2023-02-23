FROM arm64v8/python:3.9.13 as build

RUN apt update && apt install -y zip

RUN mkdir -p layer/python/lib/python3.9/site-packages

RUN pip install pytorch fairseq -t layer/python/lib/python3.9/site-packages/ \
    && pip install transformers==4.26.0 -t layer/python/lib/python3.9/site-packages/ \
    && cd layer && zip -r mypackage.zip *

FROM debian:buster-slim
COPY --from=build /layer/mypackage.zip /opt/layer.zip