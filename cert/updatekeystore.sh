#!/bin/bash

KEYSTORE=$1

CERT_NAME=cas

CURRENT=$(pwd)

if [[ "$CURRENT" != */cert ]] ; then 
    cd cert
    if [ $? -eq 1 ] ; then 
        echo "Invalid home path $CURRENT"
        exit 1
    fi
fi

if [ ! -f cas.p12 ]; then

    # Generate certificates for the Custom Root CA
    # cas.pem - your certificate
    # cas-key.pem - the private key of the certificate
    # cas.csr - a certificate request that we won’t use
    if [ ! -f cas.pem ]; then
        cfssl gencert --remote https://support-ssl.wedeploy.io req-cert.json  | cfssljson -bare $CERT_NAME - 
    fi

    cat cas.pem RootCA/ca.pem > cas-all-certs.pem
    openssl pkcs12 -export -inkey cas-key.pem -in cas-all-certs.pem  -name cas -out cas-all.p12
    keytool -storepass changeit -importkeystore -srckeystore cas-all.p12 -srcstoretype pkcs12 -destkeystore $KEYSTORE 
    keytool -list -keystore $KEYSTORE -v -storepass changeit

else 
    echo "It seems you have already generated the cas certificates. Please remove all cert/$CERT_NAME* files if you want to update the $KEYSTORE with new certificates."
fi

cd $CURRENT