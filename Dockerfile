ARG PYTHON_VERSION
FROM --platform=linux/amd64 python:${PYTHON_VERSION}-slim

RUN apt-get update && \
    apt-get install -q -y --no-install-recommends software-properties-common git gpg-agent curl && \
    echo "deb http://apt.postgresql.org/pub/repos/apt noble-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc > /etc/apt/trusted.gpg.d/apt.postgresql.org.asc && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends \
    libgdal34 \
    postgresql-client-17 && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --break-system-packages setuptools tox

ADD . /app
WORKDIR /app
CMD ["/bin/bash"]
