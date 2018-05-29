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

```
Usage: ./coreos_production_qemu.sh [-a authorized_keys] [--] [qemu options...]
Options:
    -i FILE     File containing an Ignition config
    -u FILE     Cloudinit user-data as either a cloud config or script.
    -c FILE     Config drive as an iso or fat filesystem image.
    -a FILE     SSH public keys for login access. [~/.ssh/id_{dsa,rsa}.pub]
    -p PORT     The port on localhost to map to the VM's sshd. [2222]
    -s          Safe settings: single simple cpu and no KVM.
    -h          this ;-)

This script is a wrapper around qemu for starting CoreOS virtual machines.
The -a option may be used to specify a particular ssh public key to give
login access to. If -a is not provided ~/.ssh/id_{dsa,rsa}.pub is used.
If no public key is provided or found the VM will still boot but you may
be unable to login unless you built the image yourself after setting a
password for the core user with the 'set_shared_user_password.sh' script.

Any arguments after -a and -p will be passed through to qemu, -- may be
used as an explicit separator. See the qemu(1) man page for more details.
```