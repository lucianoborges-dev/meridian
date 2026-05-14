kubectl kustomize overlays\seatunnel-master
kubectl apply -k overlays\seatunnel-master
kubectl port-forward svc/seatunnel-master 8080:8080

kubectl kustomize overlays\seatunnel-worker
kubectl apply -k overlays\seatunnel-worker
kubectl port-forward svc/seatunnel-worker 8080:8080