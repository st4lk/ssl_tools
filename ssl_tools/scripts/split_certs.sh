#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <out_path>"
    exit 1
fi
# Old versions of csplit doesn't support `{*}` argument, for example on Mac OS X 10.14.4.
# Have to count occurrences and pass it to the csplit explicitly.
tee > .tmp_cert
cert_count="$(cat .tmp_cert | grep -o "\-END CERTIFICATE\-" | wc -l)"
cert_count=$(($cert_count - 2))
[ $cert_count -le -1 ] && cert_count=0
out_path=$1

# Clean existing files
rm -f ${out_path}/certificate_*
# Split
cat .tmp_cert | csplit -s -f ${out_path}/certificate_ - '/-END CERTIFICATE-/1' '{'${cert_count}'}'
rm .tmp_cert
# Format all produced files
for file in ${out_path}/certificate_*
do
    bash `dirname $0`/decode_cert.sh $file | cat > ${file}.pem
    rm -f $file
done
