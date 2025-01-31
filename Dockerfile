FROM python:3.11.11-bullseye as open-webui-custom
WORKDIR /opt/open_webui
# Install SQLLite >= 34.5
ENV PATH=/opt/sqlite/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/sqlite/lib
ENV LD_RUN_PATH=/opt/sqlite/lib
RUN apt update -y \
    && apt install -y wget \
    && wget https://www.sqlite.org/2024/sqlite-autoconf-3450200.tar.gz \
    && tar -xzvf sqlite-autoconf-3450200.tar.gz \
    && cd sqlite-autoconf-3450200 \
    && ./configure --prefix=/opt/sqlite \
    && make \
    && make install \
    && which sqlite3
COPY ./requirements.txt /opt/open_webui/requirements.txt
RUN  apt update -y \
    &&  apt install -y gcc g++ \
    &&  pip install -r requirements.txt 
CMD ["open-webui", "serve"]

FROM ollama/ollama:latest as ollama-custom
USER root
RUN apt update -y \
    && ollama serve & sleep 30 \
    && ollama pull deepseek-r1:1.5b
ENTRYPOINT ["ollama", "serve"]

