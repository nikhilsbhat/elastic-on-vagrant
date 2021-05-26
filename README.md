# Elasticsearch and Kibana on vagrant

Ansible code base to quickly launch and test [elasticsearch](https://www.elastic.co/elasticsearch/) and [kibana](https://www.elastic.co/kibana) setup on [vagrant](https://www.vagrantup.com/).

* This ansible setup depends on following roles from ansible-galaxy: 
    * [ansible-elasticsearch](https://galaxy.ansible.com/elastic/elasticsearch)
    * [ansible-kibana](https://galaxy.ansible.com/geerlingguy/kibana)
    * [ansible-beats](https://galaxy.ansible.com/elastic/beats)
    * [ansible-node-exporter](https://galaxy.ansible.com/cloudalchemy/node_exporter)

* All dependencies can be fetched by running `make fetch_dependencies`
* The role for elasticsearch-kibana is written to run these on https.
* For generating self-signed certificate that could be used run `make generate_certs`.
* By default `make generate_certs` generates certificates under directory `certificates` which is part of this repo.
* To change the certificate path update respective variable declared in makefile.
* To know all available make target run just `make help`.

**Note:** Passwords are declared in vars as a defaults, update the respective variable if its change.

