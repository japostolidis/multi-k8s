docker build -t japostolidis/multi-client:latest -t japostolidis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t japostolidis/multi-server:latest -t japostolidis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t japostolidis/multi-worker:latest -t japostolidis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push japostolidis/multi-client:latest
docker push japostolidis/multi-server:latest
docker push japostolidis/multi-worker:latest

docker push japostolidis/multi-client:$SHA
docker push japostolidis/multi-server:$SHA
docker push japostolidis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=japostolidis/multi-server:$SHA
kubectl set image deployments/client-deployment client=japostolidis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=japostolidis/multi-worker:$SHA