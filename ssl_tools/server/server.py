import argparse
import http.server
import os
import ssl

# BASE_DIR = os.path.dirname(os.path.realpath(__file__))
# CERT_DIR = os.path.join(BASE_DIR, '..', 'output', 'server_certificates')
# CERTIFICATE_PEM_FILE = os.path.join(CERT_DIR, 'server-cert.pem')
# PRIVATE_KEY_FILE = os.path.join(CERT_DIR, 'server-key.pem')

parser = argparse.ArgumentParser()
parser.add_argument('cert_file')
parser.add_argument('key_file')


def run_server(cert_file, key_file):
    server_address = ('0.0.0.0', 4443)
    httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
    httpd.socket = ssl.wrap_socket(
        httpd.socket,
        server_side=True,
        certfile=cert_file,
        keyfile=key_file,
    )
    print('Listening', server_address)
    httpd.serve_forever()


def check_file(file_name):
    if not os.path.isfile(file_name):
        print(f'ERROR: Can not find file {file_name} Probably you forgot to generate it.')
        exit(1)


if __name__ == '__main__':
    args = parser.parse_args()
    check_file(args.cert_file)
    check_file(args.key_file)

    run_server(args.cert_file, args.key_file)
