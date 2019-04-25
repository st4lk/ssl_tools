import argparse
import sys

from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

parser = argparse.ArgumentParser()
parser.add_argument('public_key')
parser.add_argument('signed_data_file')


def read_public_key(public_key_pem_file):
    with open(public_key_pem_file, "rb") as key_file:
        return serialization.load_pem_public_key(
            key_file.read(),
            backend=default_backend()
        )


def read_signature(signature_file):
    with open(signature_file, "rb") as signature_file_obj:
        return signature_file_obj.read()


def verify(public_key, data, signature):
    return public_key.verify(
        signature,
        data,
        # Depends on the algorithm used to create the certificate
        padding.PKCS1v15(),
        # padding.PSS(
        #     mgf=padding.MGF1(hashes.SHA256()),
        #     salt_length=padding.PSS.MAX_LENGTH
        # ),
        hashes.SHA256()
    )


if __name__ == '__main__':
    args = parser.parse_args()
    public_key = read_public_key(args.public_key)
    data = sys.stdin.read()
    signature = read_signature(args.signed_data_file)
    verify(public_key, data.encode('utf8'), signature)
    print('Signature is correct')
