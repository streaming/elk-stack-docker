# Basic ELK stack docker image
#
# Providing a fast way to run up a ELK stack, just add your own
# inputs / outputs / formatting inside the confd folder.
#
# Version	0.0.1
# Maintainer Greg Baguley <greg.baguley@gmail.com>

From ubuntu:14.04

# Install dependencies
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java7-installer curl

# Download and extract elasticsearch
RUN curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz
RUN tar xvf elasticsearch-1.3.2.tar.gz

# Download and install kibana + kopf plugins
RUN /elasticsearch-1.3.2/bin/plugin -install elasticsearch/kibana3 -url http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip
RUN /elasticsearch-1.3.2/bin/plugin -install lmenezes/elasticsearch-kopf

# Download and extract logstash
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
RUN tar xvf logstash-1.4.2.tar.gz

# Add the default input / outputs
ADD ./confd /etc/logstash/conf.d
ADD run-stack.sh run-stack.sh
RUN chmod a+x run-stack.sh

# Expose the default elasticsearch port
EXPOSE 9200

# Expose the text/json logstash ports (see 01-default-tcp-input.conf)
EXPOSE 3333
EXPOSE 3334

# Run up elasticsearch and logstash
CMD ./run-stack.sh