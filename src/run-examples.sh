#!/usr/bin/env sh

PL=${1:-java}

case "$PL" in
    "java")
        (
            cd java/java_0/
            javac LookAndSay.java
            java  LookAndSay
        )
        ;;
    "haskell")
        (
            cd haskell/
            ghc haskell_0.hs
            ./haskell_0
        )
        ;;
esac
