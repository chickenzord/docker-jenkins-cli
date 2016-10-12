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

  if [ -z "$OUTPUT_FILE" ]; then
      STDOUT=/dev/stdout
  fi
  if [ -z "$ERROR_FILE" ]; then
      STDOUT=/dev/stderr
  fi

  if [ -f "$INPUT_FILE" ]; then
    if [ -f "$PRIVATE_KEY" ]; then
      java -jar "$cli_jar" -s $JENKINS_URL -i $PRIVATE_KEY "$@" < $INPUT_FILE \
      > "$OUTPUT_FILE" 2> "$ERROR_FILE"
    else
      java -jar "$cli_jar" -s $JENKINS_URL "$@" < $INPUT_FILE \
      > "$OUTPUT_FILE" 2> "$ERROR_FILE"
    fi
  else
    if [ -f "$PRIVATE_KEY" ]; then
      java -jar "$cli_jar" -s $JENKINS_URL -i $PRIVATE_KEY "$@" \
      > "$OUTPUT_FILE" 2> "$ERROR_FILE"
    else
      java -jar "$cli_jar" -s $JENKINS_URL "$@" \
      > "$OUTPUT_FILE" 2> "$ERROR_FILE"
    fi
  fi
fi
