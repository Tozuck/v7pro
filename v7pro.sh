#!/bin/bash



apt-get update; apt-get install curl socat git nload -y

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sh || echo_error "Docker installation failed."
else
  echo_info "Docker is already installed."
fi

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
IBcNMjUwMjIyMjExMjQ2WhgPMjEyNTAxMjkyMTEyNDZaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnEglxdBjyxtt
LG4BmJj1HqyqV79T+2Qgt4UT24kK3nUlDOKY5a0JFIUn6KlIpPEDysWipbBGDnWO
c0XJzUlL8jBbH3NtoGN4pET8Aj2pPqTH+kYCjlA5lvjoG1r8NJ9jnjUYkInKVFTd
RSaBhS2TfK1qxFchHRBnHkUWK/Rx4YRCH6WTrCMMvTOIuAyy2bnwTS/96jgXrp6Y
IESD0ARQXRT3AGSQjjx4pOEV+oQ6YWKDqeNsSnWNB9+P7vpIoDv1I1+4fWomQDkj
sdTLBkxyslao4dcX45cLhXTOobOWbGVMQQezwl/+v64gTRLPI9q1ht4QizqAoAcg
w3RDMlFZEO4O9EdR2aENkux+Qm5KujtjImYRgLBCUVJlZ42t6Zqw9BuGfwgr++qs
gEwqIn//CqZYcOrp0De/8pRkjZBKIDUDJeQdH08gD2c7OVYuqL50ApV9y4sQV4Yo
9sAVSjq73//ar6AXp7PvkZkTpEYVQ6zQ8zOILnJpgXKgKbUQz85gdSxlBRP4ZPup
a4dcM3DmXNY5elmbP7MuyufL5bvQ3ChHodoWg8VNtZ7jQrrfuOOks8Zhd6/pie71
ufW8aS/Te3cqdcrzq0Xs58sFHyVh3b75FGd+ns1BUa8bzf/atTnxy2aIMQgrwvor
mifCIrqVnnuocEavQnnMHR/lZ7B9KssCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
HZCu1qzYLYi0NjTy2Y7lY5/7C2C21juwwsMOsjInnK3Qj3xY6f9E46S+wXJWmLKZ
DllSBvsvItWqkA70dxt98Uvd4ie5iXgi8yeG+K728rYaahv06aidiPiSl0Oyh1hZ
MsoIAD3AwB0eopCPaov3TyR4eyYG4pGZIOMPHwq7P8zV1UlgMxBZcygx8m5fdvXy
nciPZWcb3VYcZgDW/kY3woka4qAZyY3OJUl5AF8iJFvmR1HJo5zRQLA9hjBA4jx9
Ge7HZQdxB1ndzTzefts6HJ2PC0HfjkOCw3BIRFxInmYHO1nEuQyusAxIkGeZhoaU
nCT4Fv+7vQxUEbx3NgSi6WdP0+b0M7M39dkGZvRiSUB/T6/ecPk5yY0kCZll768Y
ExBr03IC5aP7pl0zUGv/1VrmrwOm71GbvY1G4W7/YIQykNv8XCL/nizzT5lKQLJd
xhOsasjE9gnyeBYw5FXj/6fCDBmsM9XENm2SlD3lIDkuqliiqlVqqSvOEFm8LJKp
FPCU10b4y0tsNAn4zjulCKkTR6DIfxIRRAaLFqjOqi+NN148o9Wvdz1wCwAsBkaU
BOUETqKBOYWYgb8/0nCrLuhlMt48D3nNzO2bmVWV6P1ZWqisGv1Qy+PzrPx0jJE1
sZfxuBsDp0SHxfp8AjJiZDmMxj/gdyUhtb8ocXRWotg=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d
