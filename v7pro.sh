#!/bin/bash

apt update

sudo curl -fsSL https://get.docker.com | sh

apt-get update; apt-get install curl socat git nload -y

rm -r Marzban-node


git clone https://github.com/Gozargah/Marzban-node

rm -r /var/lib/marzban-node

mkdir /var/lib/marzban-node

rm ~/Marzban-node/docker-compose.yml

cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host
    environment:
      SSL_CERT_FILE: "/var/lib/marzban-node/ssl_cert.pem"
      SSL_KEY_FILE: "/var/lib/marzban-node/ssl_key.pem"
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: "rest"
    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL

cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwMTIwMTU0MTQxWhgPMjEyNDEyMjcxNTQxNDFaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA0BPHt2lAjgm5
tlZ90h7SUb+2E5M8RoEVlF761q02YZgH3LQVAYaxyppQUNCfpMRe3PGJbXgn2RrW
A1nGEZSD139WAgdroW07irDuI2zriNu2wq6F29tW+Y1BahzdhN90vF2QK7+xjYza
hbuUiQFQHIAIydTdygY9qHiWXRVi2yEhejHtPdaUVkAb6zgCtl1bxLxCuzTFRtvw
6diK5How3OyZv08JHHEC4O7W687AGTr/+dtG/NhUHXik0MpCo5Xb+vb6dxjfN7OQ
5llVGQJBSLGVFFfCUPX7zH1Eb8fuA3zFSVnpTYa5m2TxiFHaCxLGkFxReh1DaEIv
YUyIQ9yEA5OFR2ZJPc4rSi24YSTN4mBpBa66e3doK6To0YNNS50ETh35GCa88Bm7
eDzgNjnw22V2FU2my8B3/go9l+Ps6KxeKZTZIgpy37cIpAbrj2JY+vi8DrNCIA4I
XozXxTCndrp6nhoyxuN6pum00+bgbMtNzGsPIKhPDWZfOIO2qn3vXe39W3cX8CmS
RYe9A4Nzdd7ZZdu/vhtGbEU6GdaUTQhBelbCfQ9JgsbT1Tg496lxiQLamVCKKLSS
Vmv1iPzCyHCnoJ63V+eD+s6uhzRhg/RTnjzO4aKGVsEDVMZEUhn7LqSJvRbDY4sz
9AEEEf7HDRDWxNlj3j9/ImO7etgIsisCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
Oc3O9YWatOD3Vg6l5vXQT1nLEF+qot0QG+sgKjIhgnWOEGLo0Zgq6Y0ok2tAiD83
JtI3gDTpeljSpQ8WHGLoS2yD/uY1ptRfsZVo5QyEAjeJwRJzjpgWhWn+SIfTdMEt
E5MNKiegK5Yx4cS7ifj0c2F3QRxcnt7xs6ZTja8bshuZOKsy7FgxsctoFxOvCiIX
zwIDr66k/EYcI2Xjr35MJqaLYOqqFPcIl0+eDkkCzENz3gCf1tuEkrAO5Ppt7Hcx
na0eUEPsjY2SCrujwHGUr5VKYLnrgmsZbQ46NlmSxcsTXeblnaVXnIKJ8Pym21l5
6TT9+PJOZlHEAJ9XvtdHRefHLiZ+MsIxNC3EQN06vu787Pugap6zOFS05p0TM6bT
dKSah/cz6OIf13LQv5qkQeKF9wrhnRaWjorwKnfXrVdwfujjMvTho2NsSTKjU6F/
nVsC5+VzfQugU0/8Na2tCM/g4EyU+goS7exTFYGpU5CeEuCZL5DmOzqx09l2GxuB
V5DWe9l9j0Z3xHNnF3OVin8RAvBS5EjhzajgBsL4MfaqdAHKZur0KU8H2SdWD5DJ
kniU/LjKZwJpeI939urReg9V/NopWjq5UdEJzFyAI9ed6tOHE+69xCtQ3PBlr3Zd
Zzy5gVfOJG9mF3njiScGjU04HyaLYR2WzRU+G/8ceTc=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
