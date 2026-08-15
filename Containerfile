FROM ubuntu:26.04 AS source

ADD --checksum=sha256:8b5577761c7900cac2896b5fbc1d88f5aea48b6ce771437262be2a66ab38d987 https://github.com/shiftkey/desktop/releases/download/release-3.4.13-linux1/GitHubDesktop-linux-amd64-3.4.13-linux1.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/github-desktop"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/github-desktop.png
COPY github-desktop.desktop /usr/share/applications/github-desktop.desktop
