docker build -t icerig/multi-client:latest -t icerig/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t icerig/multi-server:latest -t icerig/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t icerig/multi-worker:latest -t icerig/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push icerig/multi-client:latest
docker push icerig/multi-server:latest
docker push icerig/multi-worker:latest
docker push icerig/multi-client:$SHA
docker push icerig/multi-server:$SHA
docker push icerig/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=icerig/multi-server:$SHA
kubectl set image deployments/client-deployment client=icerig/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=icerig/multi-worker:$SHA