

### Deploying via Nomad to test environment
````
export NOMAD_ADDR=http://192.168.4.7:4646
export DOCKER_REGISTRY_ADDRESS=http://registry.test.alexanderhopgood.com
export DOCKER_REGISTRY_USERNAME="jenkins"
export DOCKER_REGISTRY_PASSWORD=")cBr]8wqLHzDYbtsg{SFTIr8Zz"

levant render -log-level debug -var-file ".env-template.yaml" tech-radar.nomad
levant plan -log-level debug -var-file ".env-template.yaml" tech-radar.nomad
levant deploy -log-level debug -var-file ".env-template.yaml" tech-radar.nomad
```