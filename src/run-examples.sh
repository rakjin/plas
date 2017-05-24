#!/usr/bin/env sh

set -e

PL=${PL:-java}
EXAMPLES=${@:-all}
if [ "$EXAMPLES" = "all" ]; then
    EXAMPLES=$(ls "$PL" | sort)
fi

case "$PL" in
    "java")
        (
            cd java
            for EXAMPLE in $(echo "$EXAMPLES"); do
                javac "$EXAMPLE"/*.java
                java -classpath . "$EXAMPLE.LookAndSay"
            done
        )
        ;;
    "haskell")
        (
            cd haskell
            for EXAMPLE in $(echo "$EXAMPLES"); do
                ghc "$EXAMPLE"
                ./"${EXAMPLE%.hs}"
            done
        )
        ;;
    "javascript")
        (
            cd javascript
            for EXAMPLE in $(echo "$EXAMPLES"); do
                node --max_old_space_size=4096 "$EXAMPLE"
            done
        )
        ;;
esac
