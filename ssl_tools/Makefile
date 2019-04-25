SHELL := /bin/bash

DOMAIN ?= www.google.com
PORT ?= 443
SCRIPTS_PATH ?= ./scripts
URL ?= https://localhost:4443
OUT_PATH ?= output
PYCRYPT_PATH ?= python_cryptography
PYCRYPT_OUT_PATH ?= $(OUT_PATH)/pycrypt
PYCRYPT_PRIVATE_KEY ?= $(PYCRYPT_OUT_PATH)/key_private.pem
PYCRYPT_PUBLIC_KEY ?= $(PYCRYPT_OUT_PATH)/key_public.pem
SERVER_CERT ?= $(OUT_PATH)/server_certificates/server-cert.pem
SERVER_KEY ?= $(OUT_PATH)/server_certificates/server-key.pem

clean:
	rm -rf .install-py

show-cert:
	bash $(SCRIPTS_PATH)/show_cert.sh $(DOMAIN) $(PORT)

download-cert:
	bash $(SCRIPTS_PATH)/show_cert.sh $(DOMAIN) $(PORT) | $(SCRIPTS_PATH)/split_certs.sh $(OUT_PATH)

decode-cert:
	bash $(SCRIPTS_PATH)/decode_cert.sh $(CERT_PEM)

issue-self-signed-cert:
	bash scripts/issue_root_self_signed.sh

create-cert-request:
	bash scripts/create_cert_request.sh

sign-cert:
	bash scripts/sign_cert.sh

generate-server-certs: issue-self-signed-cert create-cert-request sign-cert

hash-cert:
	bash $(SCRIPTS_PATH)/hash_cert.sh $(CERT_PEM)

# --------------- #
# python commands #
# --------------- #
run-server:
	python ./server/server.py $(SERVER_CERT) $(SERVER_KEY)

show-urllib-ca-path:
	python -c "import ssl; print(ssl.get_default_verify_paths())"

show-requests-ca-file: install-py
	python -m certifi

fetch-url-urllib: install-py
	python -c "import urllib.request; print(urllib.request.urlopen('$(URL)').read())"

fetch-url-requests: install-py
	python -c "import requests; print(requests.get('$(URL)').content)"

generate-rsa-keys: install-py create-pycrypt-dirs
	python $(PYCRYPT_PATH)/generate_rsa_keys.py --out=$(PYCRYPT_OUT_PATH)

rsa-encrypt: install-py create-pycrypt-dirs
	@python $(PYCRYPT_PATH)/encrypt_rsa.py $(PYCRYPT_PUBLIC_KEY)

rsa-decrypt: install-py create-pycrypt-dirs
	python $(PYCRYPT_PATH)/decrypt_rsa.py $(PYCRYPT_PRIVATE_KEY)

rsa-sign: install-py create-pycrypt-dirs
	@python $(PYCRYPT_PATH)/sign_rsa.py $(PYCRYPT_PRIVATE_KEY)

rsa-verify: install-py create-pycrypt-dirs
	python $(PYCRYPT_PATH)/verify_rsa.py $(PYCRYPT_PUBLIC_KEY) $(FILE_WITH_SIGNATURE)

install-py: .install-py
.install-py:
	pip install -r requirements.txt
	@touch $@

create-pycrypt-dirs:
	@mkdir -p $(PYCRYPT_OUT_PATH)
