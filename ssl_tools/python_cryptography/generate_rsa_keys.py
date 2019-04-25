import argparse
import os

from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa

parser = argparse.ArgumentParser()
parser.add_argument('--out', default='.')


def generate_keys():
    private_key = rsa.generate_private_key(
        public_exponent=65537,
        key_size=2048,
        backend=default_backend()
    )
    public_key = private_key.public_key()

    return private_key, public_key


def dump_private_key(private_key):
    return private_key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=serialization.NoEncryption()
    )


def dump_public_key(public_key):
    return public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo,
    )


if __name__ == '__main__':
    args = parser.parse_args()
    private_key, public_key = generate_keys()

    private_key_file_path = os.path.join(args.out, 'key_private.pem')
    with open(private_key_file_path, 'wb') as f:
        f.write(dump_private_key(private_key))

    public_key_file_path = os.path.join(args.out, 'key_public.pem')
    with open(public_key_file_path, 'wb') as f:
        f.write(dump_public_key(public_key))
