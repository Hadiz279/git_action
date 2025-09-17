Tasks: Github actions CI (Continous Integration)

CI Task

- Every commit is automatically built,linted,tested and validated

- if it succeeds its pushed to dockerhub

#Dockerfile

install essential tools for hardening/securing

configure a non-root user

#Compose.yaml

- creates two nodes accessible via ssh on host port...

#CI Pipeline

- triggers on every push to main or pull request
- lint(enforce best practices when writing instructions
- test (spin up the two nodes, confirm its runnng and verifies its SSH is accessible via its port
- shutdown compose services to free runner resources
- push the validated image to dockerhub
