import argparse
import sys

from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

parser = argparse.ArgumentParser()
parser.add_argument('public_key')


def read_public_key(public_key_pem_file):
    with open(public_key_pem_file, "rb") as key_file:
        return serialization.load_pem_public_key(
            key_file.read(),
            backend=default_backend()
        )


def encrypt(public_key, data):
    return public_key.encrypt(
        data,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )


if __name__ == '__main__':
    args = parser.parse_args()
    public_key = read_public_key(args.public_key)
    data = sys.stdin.read()
    encrypted_data = encrypt(public_key, data.encode('utf8'))
    sys.stdout.buffer.write(encrypted_data)  # write binary
