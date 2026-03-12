#!/bin/sh
# Maven wrapper bootstrap script for this repository.
set -e

BASE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
WRAPPER_DIR="$BASE_DIR/.mvn/wrapper"
PROPERTIES_FILE="$WRAPPER_DIR/maven-wrapper.properties"
WRAPPER_JAR="$WRAPPER_DIR/maven-wrapper.jar"

if [ ! -f "$PROPERTIES_FILE" ]; then
  echo "Error: Missing $PROPERTIES_FILE" >&2
  exit 1
fi

trim() {
  printf '%s' "$1" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

read_property() {
  key="$1"
  value=$(grep -E "^[[:space:]]*${key}[[:space:]]*=" "$PROPERTIES_FILE" | tail -n 1 | cut -d '=' -f 2-)
  trim "$value"
}

WRAPPER_URL=$(read_property "wrapperUrl")
if [ -z "$WRAPPER_URL" ]; then
  WRAPPER_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"
fi

mkdir -p "$WRAPPER_DIR"

if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Maven wrapper from $WRAPPER_URL"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$WRAPPER_URL" -o "$WRAPPER_JAR"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$WRAPPER_JAR" "$WRAPPER_URL"
  else
    echo "Error: curl or wget is required to download maven-wrapper.jar" >&2
    exit 1
  fi
fi

if [ -n "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ]; then
  JAVACMD="$JAVA_HOME/bin/java"
else
  JAVACMD=$(command -v java || true)
fi

if [ -z "$JAVACMD" ]; then
  echo "Error: Java is not installed or not found in PATH." >&2
  exit 1
fi

exec "$JAVACMD" \
  -Dmaven.multiModuleProjectDirectory="$BASE_DIR" \
  -classpath "$WRAPPER_JAR" \
  org.apache.maven.wrapper.MavenWrapperMain "$@"
