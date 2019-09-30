#!/bin/bash
set -o errexit
set -o nounset


# Decrypt Base64 encoded string encrypted using AWS KMS CMK keys
AWS_REGION="${AWS_REGION:-""}"
KMS_PREFIX="${KMS_PREFIX:-"base64"}"

if [[ -n "${AWS_REGION}" ]]; then 
    for ENV_VAR in $( printenv ); do
        KEY="$( echo "${ENV_VAR}" | cut -d'=' -f1)"
        VALUE="$( echo "${ENV_VAR}" | cut -d'=' -f2)"

        case $VALUE in ${KMS_PREFIX}:*)
            echo "AWS KMS - Decrypting Key ${KEY}..."
            echo ${VALUE#"${KMS_PREFIX}:"} | base64 -d > "/tmp/ENV-${KEY}-cipher.blob"
            VALUE="$(aws --region "${AWS_REGION}" kms decrypt --ciphertext-blob "/tmp/ENV-${KEY}-cipher.blob" --output text --query Plaintext | base64 -d || return $?)"
            eval "export ${KEY}=${VALUE}"
        esac
    done
fi

exec /run.sh "$@"
