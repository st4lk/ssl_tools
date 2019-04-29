SHELL := /bin/bash

DOMAIN ?= www.google.com
PORT ?= 443
SCRIPTS_PATH ?= ./scripts
URL ?= https://localhost:4443
OUT_PATH ?= output
PYCRYPT_PATH ?= python_cryptography
PYCRYPT_OUT_PATH ?= $(OUT_PATH)/pycrypt
PYCRYPT_PRIVATE_KEY ?= $(PYCRYPT_OUT_PATH)/key_private.pem
CA_PATH ?= "0"
CA_FILE ?= "0"

clean:
	rm -rf .install-py

show-cert:
	bash $(SCRIPTS_PATH)/show_cert.sh $(DOMAIN) $(PORT)

download-cert:
	bash $(SCRIPTS_PATH)/show_cert.sh $(DOMAIN) $(PORT) | $(SCRIPTS_PATH)/split_certs.sh $(OUT_PATH)

decode-cert:
	bash $(SCRIPTS_PATH)/decode_cert.sh $(CERT_PEM)

issue-self-signed-cert:
	bash $(SCRIPTS_PATH)/issue_root_self_signed.sh

create-cert-request:
	bash $(SCRIPTS_PATH)/create_cert_request.sh

sign-cert:
	bash $(SCRIPTS_PATH)/sign_cert.sh

generate-server-certs: issue-self-signed-cert create-cert-request sign-cert

show-hash-cert:
	@bash $(SCRIPTS_PATH)/show_hash_cert.sh $(CERT_PEM)

show-hash-cert-issuer:
	@bash $(SCRIPTS_PATH)/show_hash_issuer_cert.sh $(CERT_PEM)

show-openssl-cert-path:
	@bash $(SCRIPTS_PATH)/show_openssl_cert_path.sh

extract-public-key:
	@bash $(SCRIPTS_PATH)/extract_public_key.sh $(CERT_PEM)

extract-signature:
	@bash $(SCRIPTS_PATH)/extract_signature.sh $(CERT_PEM)

decrypt-signature:
	bash $(SCRIPTS_PATH)/decrypt_signature.sh $(PUBLIC_KEY) $(SIGNATURE)

calc-digest:
	bash $(SCRIPTS_PATH)/extract_body.sh $(CERT_PEM) | bash $(SCRIPTS_PATH)/calc_digest.sh

verify-cert-chain:
	bash $(SCRIPTS_PATH)/verify_chain.sh $(LEAF_CERT_PEM) $(INTERMEDIATE_CERM_PEM)

verify-cert-single:
	bash $(SCRIPTS_PATH)/verify_single.sh $(CERT_PEM)

verify-custom-cert:
	bash $(SCRIPTS_PATH)/verify_custom.sh $(CERT_PEM) $(CA_PATH) $(CA_FILE)

decode-crl:
	bash $(SCRIPTS_PATH)/show_crl_contents.sh $(CRL_URL) | bash $(SCRIPTS_PATH)/decode_crl.sh

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

rsa-verify-cert: install-py create-pycrypt-dirs
	python $(PYCRYPT_PATH)/verify_rsa_x509.py $(PUBLIC_KEY) $(CERT_PEM)

install-py: .install-py
.install-py:
	pip install -r requirements.txt
	@touch $@

create-pycrypt-dirs:
	@mkdir -p $(PYCRYPT_OUT_PATH)
