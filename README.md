# Deploy prometheus-exporter on devstack VM using Puppet in docker
#### It's small guide how to deploy prometheus-exporter on devstack VM using different tools

## Deploy VM

* Download ubuntu-18.04 cloud image from https://cloud-images.ubuntu.com/bionic/ 
  * *You can use wget:* `<wget https://cloud-images.ubuntu.com/bionic/<release_date>/bionic-server-cloudimg-amd64.img>`
  * *Or download just using your browser*
* Convert image
  * `<qemu-img resize /mnt/hdd/images/bionic-server-cloudimg-amd64.img +60GB>`
  * `<qemu-img convert -f raw -O qcow2 /mnt/hdd/images/bionic-server-cloudimg-amd64.img /mnt/hdd/images/bionic.qcow2>` *(directories used by me)*
* Create config.iso with user definition using *devstack_vm/meta-data and devstack_vm/user-data* (change rsa.key in user-data) from this repo
  * `<genisoimage -output config.iso -volid cidata -joliet -rock user-data meta-data>`
* Define and start VM from *devstack_vm/domain.xml*
  * `<virsh define devstack_vm/domain.xml>`
  * `<virsh start devstack --console>`
  
## Deploy Devstack env on VM

* Clone official repository https://opendev.org/openstack/devstack
* Go into official guide

## Deploy Puppet in docker

* Install docker to vm
  * `<sudo apt-get install docker-ce -y>`
* Pull images from officials repos for puppet services
  * `<docker pull puppet/puppetserver>`
  * `<docker pull puppet/puppetdb>`
  * `<docker pull puppet/puppetdb-postgres>`
  * `<docker pull puppet/puppetboard>`
  * `<docker pull puppet/puppetexplorer>`
* Init docker-swarm 
  * `<docker swarm init --advertise-addr <ip-addr of the network used by swarm> >` (in our case we are used swarm on single-mode)
* Deploy Docker stack
  * `<docker stack deploy --compose-file docker/compose/puppet/docker-compose.yml puppet>`
* Check docker services
  * `<docker service ls>`
  * `<docker service logs puppet>

## Run Puppet manifest

* Install Prometheus puppet module
  * go to puppet-server container `<docker container exec -it bash <id-container>`
  * run puppet module install puppet-prometheus --version 8.5.0
* Apply puppet manifest
  * `<puppet apply puppet_manifest/prometheus.pp>`

!!! finish this part
