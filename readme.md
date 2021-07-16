# This repo is dedicated to repair synology ipv6 bug when use docker.

## import things: 

```shell
this project only verified in
synology_apollolake_918+ DSM 6.2.3-25426
docker version: 20.10.3-0554
```

#### 1.set docker config file

```shell
/var/packages/Docker/etc/dockerd.json
{
		"data-root" : "/var/packages/Docker/target/docker",
		"log-driver" : "db",
		"registry-mirrors" : [],
		"storage-driver" : "btrfs",
		"ipv6": true,
		"fixed-cidr-v6": "fd00::/80",
		"experimental": true,
		"ip6tables": true,
		"userland-proxy": true
}
```

#### 2.run this code

```shell
git clone -b master --single-branch https://github.com/wangliangliang2/fix_synology_docker_ipv6.git
cd fix_synology_docker_ipv6
chmod +x fix.sh
./fix.sh
```

#### 3.ipv6 test

```shell
docker run --rm -it busybox ping -6 -c4 ipv6-test.com
```



#### In case, if you docker version is 18.09.0-0519, add this manually.

```shell
ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
```

#### run docker manually【only use when you want to troubleshot】

```shell
/var/packages/Docker/target/usr/bin/dockerd --config-file /var/packages/Docker/etc/dockerd.json
```

#### some import path：

```shell
/var/packages/Docker/conf/upstart/pkg-Docker-dockerd.conf
/var/packages/Docker/scripts/start-stop-status
/usr/syno/etc.defaults/iptables_modules_list
```



## PS:  if you want to use ddsm modify the start-stop-status file.

