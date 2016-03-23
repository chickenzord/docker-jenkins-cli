# Docker Jenkins-CLI

Docker image for Jenkins CLI based on Alpine Linux. The container will use `jenkins-cli.jar` downloaded from target host.


## Sample run command

Without auth:

```
docker run -it --rm \
  -e "JENKINS_URL=http://jenkins.example.com:8080" \
  chickenzord/jenkins-cli help
```

With auth:

```
docker run -it --rm \
  -v $HOME/.ssh:/ssh \
  -e "JENKINS_URL=http://jenkins.example.com:8080" \
  chickenzord/jenkins-cli help
```

Replace `help` with your jenkin-cli command. See [Jenkins CLI wiki page](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CLI) for more information.


## Configuration

The CLI can be configured using environment variables.

- `JENKINS_URL`: **required**
- `PRIVATE_KEY`: *optional* (default: `/ssh/id_rsa`)
