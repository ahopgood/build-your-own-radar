

### Deploying via Nomad to test environment
````
export NOMAD_ADDR=http://192.168.4.7:4646

levant render -log-level debug -var-file ".test-template.yaml" tech-radar.nomad
levant plan -log-level debug -var-file ".test-template.yaml" tech-radar.nomad
levant deploy -log-level debug -var-file ".test-template.yaml" tech-radar.nomad
```