import argparse

from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import padding

parser = argparse.ArgumentParser()
parser.add_argument('public_key')
parser.add_argument('cert_file')


def read_public_key(public_key_pem_file_name):
    with open(public_key_pem_file_name, "rb") as key_file:
        return serialization.load_pem_public_key(
            key_file.read(),
            backend=default_backend()
        )


def read_x509_certificate(cert_file_name):
    with open(cert_file_name, 'rb') as cert_file:
        return x509.load_pem_x509_certificate(cert_file.read(), default_backend())


def verify_x509(public_key, cert_to_check):
    return public_key.verify(
        cert_to_check.signature,
        cert_to_check.tbs_certificate_bytes,
        # Depends on the algorithm used to create the certificate
        padding.PKCS1v15(),
        cert_to_check.signature_hash_algorithm,
    )


if __name__ == '__main__':
    args = parser.parse_args()
    public_key = read_public_key(args.public_key)
    cert_to_check = read_x509_certificate(args.cert_file)
    verify_x509(public_key, cert_to_check)
    print('Signature is correct')
