#!/bin/bash

# echo "$@"
if test -z "$JENKINS_URL"; then
  echo "JENKINS_URL environment variable is mandatory"
  exit 1
else
  url_hash=$(echo $JENKINS_URL | md5sum)

  mkdir -p "$url_hash"
  echo $JENKINS_URL > "$url_hash/url.txt"

  cli_jar="$url_hash/jenkins-cli.jar"
  if [ ! -f "$cli_jar" ]; then
    wget "$JENKINS_URL/jnlpJars/jenkins-cli.jar" -q -O "$cli_jar"
  fi

  if [ -f "$PRIVATE_KEY" ]; then
    java -jar "$cli_jar" -s $JENKINS_URL -i $PRIVATE_KEY "$@"
  else
    java -jar "$cli_jar" -s $JENKINS_URL "$@"
  fi
fi
