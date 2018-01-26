gcloud container clusters create wdpress \
    --machine-type=g1-small
# kubectlがクラスタに接続できるように、k8sクラスタの認証情報をダウンロード
gcloud container clusters get-credentials wdpress
gcloud container builds submit --config=cloudbuild.yaml .

# just for study, skip to kind: Deployment
## kind: Pod
kubectl delete -f pod.yaml
kubectl create -f pod.yaml
kubectl get pods
kubectl port-forward hello-world 8080
curl http://localhost:8080/
kubectl create -f pod-configmap.yaml
kubectl create -f configmap.yaml
kubectl delete -f pod-configmap.yaml 
kubectl delete -f configmap.yaml     
## kind: ReplicaSet
kubectl create -f replicaset.yaml
kubectl delete -f replicaset.yaml
kubectl get pods
kubectl delete pod hello-world-93bg2
replicas: 3 > 4
kubectl replace -f replicaset.yaml

# kind: Deployment
kubectl create -f deployment.yaml
replicas: 3 > 4
kubectl replace -f deployment.yaml
kubectl get replicaset
kubectl get pods
# kind: Service
# typeにLoadBalancerを指定したので、Serviceが作成されてしばらく待っていると外部IPアドレスが付与されます。
# ServiceはL4プロキシ
kubectl create -f service.yaml
kubectl get service -w hello-world
kubectl get service hello-world
# L7プロキシはIngress
# k8sからMaglev(分散ロードバランサ)を使うには、Ingressを利用
# GCPの場合はHTTP Load Balancer（以下、HTTPLB）で実現
# AWSの場合はApplication LoadBalancerで実現
# Ingressを使う場合はServiceの定義からLoadBalancerの行を削除
nvim service.yaml # dd type: LoadBalancer 
```
# add
spec:
  type: NodePort
```
kubectl replace -f service.yaml
kubectl create -f ingress.yaml
# 数分後にはIPアドレスがHTTPロードバランサに付与され利用可能となる
kubectl get ingress hello-world

# kill
kubectl delete -f ingress.yaml
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
gcloud container clusters delete wdpress
gcloud container clusters list
