FROM ubuntu:20.04
COPY elasticsearch-7.15.0-linux-aarch64.tar.gz /opt
RUN groupadd -r elasticsearch && useradd -r -g elasticsearch elasticsearch

RUN tar xzf /opt/elasticsearch-*.tar.gz -C /opt &&\
    rm /opt/elasticsearch-*.tar.gz &&\
    ln -s /opt/elasticsearch-* /opt/elasticsearch &&\
    /opt/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji &&\
    echo "network.host: 0.0.0.0" >> /opt/elasticsearch/config/elasticsearch.yml &&\
    echo "discovery.type: single-node" >> /opt/elasticsearch/config/elasticsearch.yml &&\
    echo "xpack.ml.enabled: false" >> /opt/elasticsearch/config/elasticsearch.yml 
#perl -pi -e "s/Xms1g/Xms512m/" /opt/elasticsearch/config/jvm.options &&\
#perl -pi -e "s/Xmx1g/Xmx512m/" /opt/elasticsearch/config/jvm.options

RUN chown -R elasticsearch:elasticsearch /opt/elasticsearch-*
USER elasticsearch

CMD ["/opt/elasticsearch/bin/elasticsearch"]
