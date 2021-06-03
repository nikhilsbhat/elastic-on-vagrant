function elastic_stress_test() {
  ES_URL=$1
  CA_CERT_PATH=$2
  USERNAME=$3
  PASSWORD=$4
  /usr/bin/python infrastructure/elastic-stress-test/elasticsearch-stress-test.py --es_address "$ES_URL" --indices 5 --documents 20 --number-of-shards 10 --username "$USERNAME" --password "$PASSWORD" --not-green --clients 6 --seconds 360 --ca "$CA_CERT_PATH"
}

elastic_stress_test "$@"
