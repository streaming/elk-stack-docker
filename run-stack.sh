#!/bin/sh

/elasticsearch-1.3.2/bin/elasticsearch &
/logstash-1.4.2/bin/logstash agent -f /etc/logstash/conf.d -l /var/log/logstash.log