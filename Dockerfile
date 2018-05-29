FROM debian

RUN apt-get update && \
    apt-get install -y qemu-system-x86 qemu-utils curl && \
    mkdir /coreos && cd /coreos && \
    curl https://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu.sh --output coreos_production_qemu.sh && \
    apt-get purge -y curl && apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chmod +x /coreos/coreos_production_qemu.sh

WORKDIR /coreos
ENTRYPOINT ["./coreos_production_qemu.sh"]
