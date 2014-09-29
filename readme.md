Basic ELK Stack in Docker
=========================

This repo contains a very basic Dockerfile for quickly running up a complete ELK stack.

The Dockerfile provides the following features:  
* Elasticsearch 1.3.2  
  * kopf plugin (http://`hostname`:9200/_plugin/kopf/)  
  * kibana3 plugin (http://`hostname`:9200/_plugin/kibana3/)  


* Logstash 1.4.2  
  * elasticsearch output  
  * text input (tcp port 3333)  
  * json input (tcp port 3334)  

To add your own inputs / outputs / formatters simple drop your conf files into the confd folder before building.

Building:
---------
`sudo docker build -t elk-stack .`  
With your chosen tag.

Running:
--------
`sudo docker run -p 9200:9200 -p 3333:3333 -p 3334:3334 --name elk-stack -i -t -d elk-stack`  
With your chosen name and any additional ports you require for your configuration.
