TLS (ex. SSL) tools
===================

Understand the basics of TLS (SSL) flow by examples.


Repository contains scripts to work with SSL/TLS certificates, like download, decode etc.
It use [make](https://en.wikipedia.org/wiki/Make_(software)) as a handy wrapper over bash or python scripts.

Install
-------

Choose whatever you like:

- docker

    ```bash
    docker build -t ssl_tools ./
    docker run -it -p 4443:4443 --rm -v $PWD/ssl_tools:/ssl_tools --name ssl_tools ssl_tools
    ```

    Shell inside docker:

    ```bash
    cd /ssl_tools
    python -m venv venv  # only first time
    source venv/bin/activate
    ```

    To open another shell to already running docker container:
    ```bash
    docker exec -it ssl_tools bash
    ```

    TODO: create and activate venv automatically

- vagrant

    ```bash
    vagrant up
    vagrant ssh
    ```

    Shell inside vagrant:

    ```bash
    cd /ssl_tools
    python3.6 -m venv venv  # only first time
    source venv/bin/activate

    make show-cert
    ```

    TODO: create and activate venv automatically

- local machine

    ```bash
    cd ssl_tools/ssl_tools

    python3 -m venv venv  # python >= 3.6 is expected
    source venv/bin/activate

    make show-cert
    ```

Commands
--------

- **Show SSL certificates for given domain and port**

    ```bash
    DOMAIN=github.com PORT=443 make show-cert
    ```

- **Download each SSL certificate (leaf, intermediate) into separate files and decode them**

    ```bash
    DOMAIN=github.com PORT=443 make download-cert
    ```

    Downloaded certificates will be in `output/` folder, in `certificate_xx.pem` files.
    `certificate_00.pem` is a leaf certificate, `certificate_01.pem` is first intermediate certificate and so on.

- **Decode certificate, stored in .pem file**

    ```bash
    CERT_PEM=cert.pem make decode-cert
    ```

- **Issue self signed certificate, sign server certificate with it**

    ```bash
    make generate-server-certs
    ```

    The output dir will contain:
    - root self-signed certificate
    - private key for root self-signed certificate
    - certificate signing request (CSR)
    - server certificate, signed by root certificate
    - private key for server certificate

    Output dir is `output/server_certificates` (it is hard-coded).
    Params for root certificate are in `server/openssl-ca.cnf` file.
    Params for server certificate are in `server/openssl-ca-server.cnf` file.

- **Run server, that will use generated certificate**

    ```bash
    make run-server
    ```

    Server will listen on https://localhost:4443

- **Fetch URL using python's urllib**

    ```bash
    URL=https://localhost:4443 make fetch-url-urllib
    ```

    It is possible to specify custom file with trusted root SSL certificates using `SSL_CERT_FILE` env variable:
    ```bash
    SSL_CERT_FILE=output/server_certificates/root-self-signed-cert.pem URL=https://localhost:4443 make fetch-url-urllib
    ```

    It is possible to specify custom dir with trusted root SSL certificates using `SSL_CERT_DIR` env variable.
    That dir should contain PEM certificates with file name equal to certificate hash + `.0`.
    Check `make hash-cert`.
    ```bash
    SSL_CERT_DIR=output/server_certificates/ URL=https://localhost:4443 make fetch-url-urllib
    ```

- **Fetch URL using python's requests module**

    ```bash
    URL=https://localhost:4443 make fetch-url-requests
    ```

    It is possible to specify custom file with trusted root SSL server_certificates using `REQUESTS_CA_BUNDLE` env variable:
    ```bash
    REQUESTS_CA_BUNDLE=output/server_certificates/root-self-signed-cert.pem URL=https://localhost:4443 make fetch-url-requests
    ```

    That env variable can point to dir as well. It is similar to `SSL_CERT_DIR`, file names should be equal to certificate hash there.
    ```bash
    REQUESTS_CA_BUNDLE=output/server_certificates/ URL=https://localhost:4443 make fetch-url-requests
    ```
- **Show CA path with root certificates, that is used by urllib**

    ```bash
    make show-urllib-ca-path
    ```

- **Show CA file with root certificates, that is used by requests library**

    ```bash
    make show-requests-ca-file
    ```

- **Hash certificate**

    ```bash
    CERT_PEM=cert.pem make hash-cert
    ```

- **Generate RSA public and private keys using python cryptography**

    ```bash
    make generate-rsa-keys
    ```

    By default, keys will be placed in `output/pycrypt/key_private.pem` and `output/pycrypt/key_public.pem`

- **Encrypt using RSA public key**

    ```bash
    echo -n 'my secret message' | make rsa-encrypt > output/encrypted.bin
    ```

    By default, public key from `output/pycrypt/key_public.pem` path will be used.

- **Decrypt using RSA private key**

    ```bash
    cat output/encrypted.bin | make rsa-decrypt
    ```

    By default, private key from `output/pycrypt/key_private.pem` path will be used.

- **Sign using RSA private key**

    ```bash
    echo -n 'my own message' | make rsa-sign > output/data_signature.bin
    ```

    By default, private key from `output/pycrypt/key_private.pem` path will be used.

- **Verify signed data using RSA public key**

    ```bash
    echo -n 'my own message' | FILE_WITH_SIGNATURE=output/data_signature.bin make rsa-verify
    ```

- **Extract public key from certificate**

    ```bash
    CERT_PEM=output/certificate_00.pem make extract-public-key > output/extracted_public_key.pem
    ```

- **Extract signature from certificate**

    ```bash
    CERT_PEM=output/certificate_00.pem make extract-signature > output/extracted_signature.pem
    ```
