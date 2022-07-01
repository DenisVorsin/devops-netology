FROM centos:7

RUN yum install -y wget perl-Digest-SHA

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.1-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.3.1-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.3.1-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.3.1-linux-x86_64.tar.gz

RUN groupadd elasticsearch && \
    useradd -g elasticsearch elasticsearch && \
    mkdir -p /elasticsearch-8.3.1/snapshots && \
    chown -R elasticsearch:elasticsearch /elasticsearch-8.3.1

RUN mkdir -p /var/lib/elastic/data && \
    mkdir -p /var/lib/elastic/logs && \
    chown -R elasticsearch:elasticsearch /var/lib/elastic

COPY elasticsearch.yml /elasticsearch-8.3.1/config/

RUN chown -R elasticsearch:elasticsearch /elasticsearch-8.3.1/config


ENV ES_HOME=/elasticsearch-8.3.1

USER elasticsearch
CMD ["/elasticsearch-8.3.1/bin/elasticsearch"]