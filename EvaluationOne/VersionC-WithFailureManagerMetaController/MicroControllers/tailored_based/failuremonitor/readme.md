# Building and deploying in docker hub
docker build -t failuremonitor .
docker tag failuremonitor californibrs/failuremonitor
docker push californibrs/failuremonitor


# Only to vallid environemtn docker (problem with k8s api)
docker run -d --name failuremonitor -p 8000:5002 californibrs/failuremonitor