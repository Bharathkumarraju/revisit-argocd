helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update
helm install sealed-secrets-controller sealed-secrets/sealed-secrets

root@host:~/workdir# ls -rtlh
total 74M
-rwxr-xr-x 1 user admin  51M Jan 16 12:49 kubeseal
drwxr-xr-x 2 root root  4.0K May  1 07:16 unsealed_secrets
-rw-r--r-- 1 root root   23M May  1 07:23 kubeseal-0.28.0-linux-amd64.tar.gz
drwxr-xr-x 2 root root  4.0K May  1 07:24 sealed_secrets
root@host:~/workdir# cd sealed_secrets/
root@host:~/workdir/sealed_secrets# ls -rtlh
total 0
root@host:~/workdir/sealed_secrets# cd ..
root@host:~/workdir# kubeseal < unsealed_secrets/db-creds.yml > sealed_secrets/db-creds-encrypted.yaml -o yaml
kubeseal < unsealed_secrets/paypal-cert.yml > sealed_secrets/paypal-cert-encrypted.yaml -o yaml
root@host:~/workdir#



