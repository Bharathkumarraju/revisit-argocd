Before we can use your CLI we need to authenticate against our own Argo CD instance.

In a production environment you might have different authentication options and also change the default admin password (or remove the admin account completely).

root@kubernetes-vm:~/workdir# argocd login localhost:30443 --insecure
Username: admin
Password:
'admin:login' logged in successfully
Context 'localhost:30443' updated
root@kubernetes-vm:~/workdir#


root@kubernetes-vm:~/workdir# argocd version
argocd: v2.11.2+25f7504
  BuildDate: 2024-05-23T13:58:43Z
  GitCommit: 25f7504ecc198e7d7fdc055fdb83ae50eee5edd0
  GitTreeState: clean
  GoVersion: go1.21.10
  Compiler: gc
  Platform: linux/amd64
argocd-server: v2.11.2+25f7504
  BuildDate: 2024-05-23T13:32:13Z
  GitCommit: 25f7504ecc198e7d7fdc055fdb83ae50eee5edd0
  GitTreeState: clean
  GoVersion: go1.21.9
  Compiler: gc
  Platform: linux/amd64
  Kustomize Version: v5.2.1 2023-10-19T20:13:51Z
  Helm Version: v3.14.4+g81c902a
  Kubectl Version: v0.26.11
  Jsonnet Version: v0.20.0
root@kubernetes-vm:~/workdir# argocd app list
NAME  CLUSTER  NAMESPACE  PROJECT  STATUS  HEALTH  SYNCPOLICY  CONDITIONS  REPO  PATH  TARGET
root@kubernetes-vm:~/workdir#



