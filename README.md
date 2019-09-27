# Grafana CodeOnTap Support

A slightly modified version of the [Grafana Docker](https://hub.docker.com/r/grafana/grafana) image with support for decrypting secrets encrypted using AWS KMS and base64 encoded as strings

Adds 2 environment variables which can be used to configure the decryption process

- AWS_REGION
  - The region where the KMS key lives which encrypted the key
  - **default** empty
- KMS_PREFIX
  - The prefix for encrypted strings so we know which ones to decrypt 
  - **default** `base64`
