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


def decrypt(private_key, data):
    return private_key.decrypt(
        data,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )


if __name__ == '__main__':
    args = parser.parse_args()
    private_key = read_private_key(args.private_key)
    data = sys.stdin.buffer.read()  # read as binary, omit decoding
    decrypted_data = decrypt(private_key, data)
    print(decrypted_data.decode('utf8'))
