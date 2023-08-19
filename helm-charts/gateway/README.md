# Geneos Gateway Helm Chart

Helm chart for installing Geneos Gateway 2 in Kubernetes.

## Docker Credentials

To pull the Gateway Docker image, a secret containing your ITRS Docker registry credentials must be created:
```
kubectl create secret docker-registry itrsdocker \
  --docker-server=https://docker.itrsgroup.com \
  --docker-username=<EMAIL_ADDRESS> \
  --docker-password=<PASSWORD>
```

## Configuration

To see all configuration options, run `helm show values ...`.

Sample config:
```yaml
licenceDaemon:
  host: my-licd-hostname
  port: 7041
  secure: false
 
tls:
  secret: my-gateway-secret

resources:
  limits:
    cpu: "1"
    memory: "1Gi"
  requests:
    cpu: "500m"
    memory: "768Mi"
```

## TLS Configuration

TLS is enabled by default.  Before installing the chart, you must create a secret containing the TLS key and certificate:
```
kubectl create secret tls my-gateway-secret --cert=path/to/tls.cert --key=path/to/tls.key
```
Otherwise, TLS can be disabled if desired:
```yaml
tls:
  enabled: false
```