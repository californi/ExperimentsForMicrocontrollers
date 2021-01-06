# Building and deploying in docker hub
docker build -t failuremanager .
docker tag failuremanager californibrs/failuremanager
docker push californibrs/failuremanager

# using mongodb
PS C:\WINDOWS\system32> minikube ip
<ip cluster>
PS C:\WINDOWS\system32> mongosh mongodb://<ip cluster>:<mongo service port>



# Only to vallid environemtn docker (problem with k8s api)
docker run -d --name failuremanager -p 8000:5002 californibrs/failuremanager