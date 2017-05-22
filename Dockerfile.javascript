# vim: set filetype=dockerfile:
FROM mhart/alpine-node

COPY src /root/
WORKDIR /root
