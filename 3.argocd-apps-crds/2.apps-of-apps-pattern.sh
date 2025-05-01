The example application is at https://github.com/codefresh-contrib/gitops-certification-examples/tree/main/declarative.


How an argocd application can be modeled as kubernetes resource.
How to manage multiple ArgoCD applications together.
How to use Gitops for the application definitions.


Take a look at https://github.com/codefresh-contrib/gitops-certification-examples/blob/main/declarative/single-app/my-application.yml



root@host:~/workdir# kubectl apply -f my-application.ymlml
Warning: metadata.finalizers: "resources-finalizer.argocd.argoproj.io": prefer a domain-qualified finalizer name to avoid accidental conflicts with other finalizer writers
application.argoproj.io/demo created
root@host:~/workdir#

root@host:~/workdir# kubectl get crds -n argocd
NAME                                    CREATED AT
addons.k3s.cattle.io                    2024-05-31T11:48:48Z
etcdsnapshotfiles.k3s.cattle.io         2024-05-31T11:48:49Z
helmcharts.helm.cattle.io               2024-05-31T11:48:50Z
helmchartconfigs.helm.cattle.io         2024-05-31T11:48:51Z
ingressroutetcps.traefik.containo.us    2024-05-31T11:49:34Z
traefikservices.traefik.io              2024-05-31T11:49:34Z
ingressrouteudps.traefik.containo.us    2024-05-31T11:49:34Z
ingressroutes.traefik.containo.us       2024-05-31T11:49:34Z
tlsstores.traefik.io                    2024-05-31T11:49:34Z
middlewares.traefik.containo.us         2024-05-31T11:49:34Z
serverstransports.traefik.io            2024-05-31T11:49:34Z
middlewaretcps.traefik.io               2024-05-31T11:49:34Z
serverstransporttcps.traefik.io         2024-05-31T11:49:34Z
middlewaretcps.traefik.containo.us      2024-05-31T11:49:34Z
tlsstores.traefik.containo.us           2024-05-31T11:49:34Z
ingressroutes.traefik.io                2024-05-31T11:49:34Z
tlsoptions.traefik.io                   2024-05-31T11:49:34Z
serverstransports.traefik.containo.us   2024-05-31T11:49:34Z
ingressrouteudps.traefik.io             2024-05-31T11:49:34Z
ingressroutetcps.traefik.io             2024-05-31T11:49:34Z
tlsoptions.traefik.containo.us          2024-05-31T11:49:34Z
traefikservices.traefik.containo.us     2024-05-31T11:49:34Z
middlewares.traefik.io                  2024-05-31T11:49:34Z
applications.argoproj.io                2024-05-31T11:51:31Z
applicationsets.argoproj.io             2024-05-31T11:51:32Z
appprojects.argoproj.io                 2024-05-31T11:51:32Z
root@host:~/workdir#

root@host:~/workdir# kubectl get appprojects -n argocd
NAME      AGE
default   334d
root@host:~/workdir# kubectl get applications -n argocd
NAME   SYNC STATUS   HEALTH STATUS
demo   Synced        Healthy
root@host:~/workdir#


root@host:~/workdir# kubectl get apps -n argocd
NAME   SYNC STATUS   HEALTH STATUS
demo   Synced        Healthy
root@host:~/workdir#




root@host:~/workdir# kubectl get apps -n argocd
NAME        SYNC STATUS   HEALTH STATUS
demo        Synced        Healthy
3-apps      Synced        Healthy
demo-app3   Synced        Healthy
demo-app1   Synced        Healthy
demo-app2   Synced        Healthy
root@host:~/workdir#


root@host:~/workdir# kubectl apply -f https://raw.githubusercontent.com/codefresh-contrib/gitops-certification-examples/refs/heads/main/declarative/parent-app/my-parent-app.yml
Warning: metadata.finalizers: "resources-finalizer.argocd.argoproj.io": prefer a domain-qualified finalizer name to avoid accidental conflicts with other finalizer writers
application.argoproj.io/my-parent-app created
root@host:~/workdir#



root@host:~/workdir# kubectl get applications -n argocd
NAME            SYNC STATUS   HEALTH STATUS
demo            Synced        Healthy
demo-app2       Synced        Healthy
demo-app1       Synced        Healthy
demo-app3       Synced        Healthy
my-parent-app   Synced        Healthy
3-apps          OutOfSync     Healthy
root@host:~/workdir#



