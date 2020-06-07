SCRIPT_DIR=$(cd $(dirname $0); pwd)

KEY=pass
PASS=aaaa

ENC=`${SCRIPT_DIR}/encryptw input=${PASS} password=${KEY} verbose=false algorithm=PBEWITHHMACSHA512ANDAES_256 ivGeneratorClassName=org.jasypt.iv.RandomIvGenerator`

echo "jasypt.encryptor.password=${KEY}" > ${SCRIPT_DIR}/../src/main/resources/application.properties
echo "test.password=ENC(${ENC})" >> ${SCRIPT_DIR}/../src/main/resources/application.properties
