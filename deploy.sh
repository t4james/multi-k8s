docker build -t t4james/multi-client:latest -t t4james/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t t4james/multi-server:latest -t t4james/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t t4james/multi-worker:latest -t t4james/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push t4james/multi-client:latest
docker push t4james/multi-server:latest
docker push t4james/multi-worker:latest

docker push t4james/multi-client:$SHA
docker push t4james/multi-server:$SHA
docker push t4james/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=t4james/multi-server:$SHA
kubectl set image deployments/client-deployment client=t4james/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=t4james/multi-worker:$SHA
