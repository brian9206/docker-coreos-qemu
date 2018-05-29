# coreos-qemu
Run CoreOS on QEMU on Docker

## How to use
First, download the latest `coreos_production_qemu_image.img`
```sh
mkdir coreos
cd coreos
wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2
wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2.sig
gpg --verify coreos_production_qemu_image.img.bz2.sig
bzip2 -d coreos_production_qemu_image.img.bz2
```

Then, create a container
```sh
docker run -td \
    --name coreos \
    --privileged \
    -v /some/dir/coreos/coreos_production_qemu_image.img:/coreos/coreos_production_qemu_image.img \
    -v /home/yourname/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro \
    coreos-qemu \
    -a /root/.ssh/id_rsa.pub \
    -p 22 \
    -cpu host \
    -smp 4 \
    -m 2G \
    -nographic
```

After that, find the container IP
```sh
docker inspect coreos | grep \"IPAddress\":
```

Finally, connect to your CoreOS ssh
```sh
ssh -l core YOUR_CONTAINER_IP
```

## More info
Read the official documentation: 
- [Running CoreOS Container Linux on QEMU](https://coreos.com/os/docs/latest/booting-with-qemu.html)

For commands, you can simply run:
```sh
docker run --rm -it coreos-qemu -h
```
