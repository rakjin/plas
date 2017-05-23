#!/usr/bin/env sh

PL=${1:-java}

run_java(){
    local SUBDIR=$1
    javac ${SUBDIR}/*.java
    java -classpath . "${SUBDIR}.LookAndSay"
}

case "$PL" in
    "java")
        (
            cd java
            run_java java_0
            run_java java_1
            run_java java_2
        )
        ;;
    "haskell")
        (
            cd haskell
            ghc haskell_0.hs
            ./haskell_0
        )
        ;;
    "javascript")
        (
            cd javascript
            node javascript_0.js
        )
        ;;
esac
