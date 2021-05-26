function generate_certs() {
    cert_config=$1
    local config_content
    config_content=$(cat "/playbooks/$cert_config.yml")

    mkdir -p /tmp/certs
    echo "generating certificates under /tmp/certs/certs.zip with config $config_content"
    elasticsearch-certutil cert --keep-ca-key --pem --in "/playbooks/$cert_config".yml --out /tmp/certs/certs.zip
}

function extract_certs() {
  certificates_root_dir=$1
  mkdir -p "$certificates_root_dir"
  echo "extracting certificates under $certificates_root_dir"
  unzip /tmp/certs/certs.zip -d ./"$certificates_root_dir"
}

function main() {
  certificates_root_dir=$1
  certs_config=$2

  generate_certs "$certs_config"
  generate_certs_status=$?
  if [ $generate_certs_status -ne 0 ]; then
    echo "generating certificates with provided configuration failed"
    exit 1
  else
    echo "generating certificates with provided configuration is successful"
  fi

  extract_certs "$certificates_root_dir"
  extract_certs_status=$?
    if [ $extract_certs_status -ne 0 ]; then
    echo "extracting generated certificates failed"
    exit 1
  else
    echo "extracting generated certificates is successful"
  fi
}

main "$@"