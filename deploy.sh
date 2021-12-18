docker build -t japostolidis/multi-client-k8s:latest -t japostolidis/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t japostolidis/multi-server-k8s:latest -t japostolidis/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t japostolidis/multi-worker-k8s:latest -t japostolidis/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push japostolidis/multi-client-k8s:latest
docker push japostolidis/multi-server-k8s:latest
docker push japostolidis/multi-worker-k8s:latest

docker push japostolidis/multi-client-k8s:$SHA
docker push japostolidis/multi-server-k8s:$SHA
docker push japostolidis/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=japostolidis/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=japostolidis/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=japostolidis/multi-worker-k8s:$SHA