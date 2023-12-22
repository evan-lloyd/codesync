FROM alpine:3.14
RUN apk add --no-cache openssh wget bash
RUN wget https://github.com/mutagen-io/mutagen/releases/download/v0.17.2/mutagen_linux_amd64_v0.17.2.tar.gz
RUN tar -xzf mutagen_linux_amd64_v0.17.2.tar.gz
RUN cp mutagen mutagen-agents.tar.gz /usr/bin

COPY entrypoint.sh /root/
RUN chmod +x /root/entrypoint.sh

RUN mkdir -p /root/.ssh && echo $'Host *\n\tStrictHostKeyChecking no' > /root/.ssh/config

COPY .mutagen.yml /root

ENTRYPOINT ["/root/entrypoint.sh"]
