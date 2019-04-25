import argparse
import sys

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization

parser = argparse.ArgumentParser()
parser.add_argument('private_key')


def read_private_key(private_key_pem_file):
    with open(private_key_pem_file, "rb") as key_file:
        return serialization.load_pem_private_key(
            key_file.read(),
            password=None,
            backend=default_backend()
        )


def sign(private_key, data):
    return private_key.sign(
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
    private_key = read_private_key(args.private_key)
    data = sys.stdin.read()
    signature = sign(private_key, data.encode('utf8'))
    sys.stdout.buffer.write(signature)  # write binary
