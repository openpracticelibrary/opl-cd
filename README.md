# Open Practice Library Manifests

This repo contains the kustomize manifests to manage the deployment lifecycle of Open Practice Library and all related services across multiple versions and environments. Manifest changes are automatically triggered to release versions of the Open Practice Library via GitHub Actions in the various code repos. It is watched by ArgoCD, automatically updating apps running in Openshift with any manifest changes.

## Bootstrap

This application follows the [App of Apps convention in ArgoCD](https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/). Should you wish to deploy it yourself with all of the automated goodies, ensure you have the basic requirements set up:
- ArgoCD installed and running on your Kubernetes cluster (we use the operator-managed version)
- For the Open Practice Library content API, the mongo databases for the environments are installed separately. There is a mongodb-values file in the `charts/` directory, which you can use to install mongo (`helm install -f mongodb-values.yaml opl-mongo .`).
- `kustomize` installed on your machine
- **kustomize does not support values files** -- as such, you will want to modify the `targetRevision` in `bootstrap/open-practice-library.yaml` directly to your desired git-ref. This will prevent Argo from updating the parent app every time a change is made to a child app manifest.

From there, you can run:
```
kustomize build bootstrap/ | kubectl apply -f -
```

## App of Apps

The Open Practice Library is a collection of microservices and a front end application, spread across 5 repositories (as of this writing). This is the "config" repo; keeping code and config separate is a [GitOps best practice](https://argoproj.github.io/argo-cd/user-guide/best_practices/). These manifests are currently set up to run a development, prerelease (staging), and production environment, all in the same cluster. You can modify the kustomization.yaml files in the appropriate app directories to change this if you wish (remove the production environment overlay from the `resources` key, for example, to deploy a production environment to a different cluster).You could also configure Argo for [multi-cluster management](https://www.openshift.com/blog/multi-cluster-management-with-gitops).

Our current GitOps processes will trigger a deployment of the development environment for a given child app whenever the master branch is updated (and the resulting image is built, tagged, and pushed). GitHub Actions are triggered in the code repos which will clone this repo and use kustomize to update the image tag, and then commit and push those changes back to this repository. The corresponding child app in Argo will pick up that change (to a `kustomization.yaml` file in one of the overlays), and automatically sync the changes to the Kubernetes objects it controls.

Want to read more about [Kustomize](https://kustomize.io/), [GitOps](https://www.cloudbees.com/gitops/what-is-gitops) or [ArgoCD](https://argoproj.github.io/argo-cd/)? Check [out](https://www.openshift.com/blog/introduction-to-gitops-with-openshift) the [links](https://www.openshift.com/blog/disaster-recovery-with-gitops) for [more](https://www.weave.works/blog/what-is-gitops-really)!

