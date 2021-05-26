ELASTICSEARCH_VERSION="7.12.1"
CERTS_ROOT_DIR="certificates"
CERTS_CONFIG_FILENAME="certs-config"

define CERTS_CONFIG
instances:
  - name: 'elasticsearch'
    dns: [ 'elasticsearch.test.local' ]
  - name: 'kibana'
    dns: [ 'kibana.test.local' ]
endef
export CERTS_CONFIG

define ENVS
ELASTIC_VERSION=$(ELASTICSEARCH_VERSION)
endef
export ENVS

.PHONY: help
help: ## Prints help (only for targets with comments)
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; \
{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

fetch_dependencies: ## Downloads dependent roles from ansible-galaxy to the path specified in 'ansible.cfg'.
	ansible-galaxy install -r requirements.yml --force

generate_certs: generate_envs generate_certs_config ## Generates all required certificates as specified in 'certs-config' file.
	docker-compose --project-name certificates -f docker-compose.playbook.yml run -e CERTS_DIR=$(CERTS_ROOT_DIR) -e CERTS_CONFIG=$(CERTS_CONFIG_FILENAME) --rm generate-certificates

generate_certs_config: ## Writes certs config to a desired file( defaults to certs-config.yml).
	echo "$$CERTS_CONFIG" > $(CERTS_CONFIG_FILENAME).yml

generate_envs:
	echo "$$ENVS" > .env
