#!/usr/bin/env sh

PL=${1:-java}

run_java(){
    local SUBDIR=$1
    (
        cd "java/${SUBDIR}"
        javac LookAndSay.java
        java  LookAndSay
    )
}

case "$PL" in
    "java")
        run_java java_0
        run_java java_1
        ;;
    "haskell")
        (
            cd haskell/
            ghc haskell_0.hs
            ./haskell_0
        )
        ;;
esac
