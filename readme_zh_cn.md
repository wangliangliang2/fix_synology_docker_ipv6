# 这个repo主要用于修复群晖docker的ipv6问题。问题主要体现在运行在container 模式时候ipv6无法连通外网。

## 重要提示: 

```shell
该项目只在以下条件下验证了
synology_apollolake_918+ DSM 6.2.3-25426
docker version: 20.10.3-0554
```

#### 1.修改docker的配置文件

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

#### 2.执行以下代码

```shell
git clone -b master --single-branch https://github.com/wangliangliang2/fix_synology_docker_ipv6.git
cd fix_synology_docker_ipv6
chmod +x fix.sh
./fix.sh
```

#### 3.ipv6 测试

```shell
docker run --rm -it busybox ping -6 -c4 ipv6-test.com
```



#### 手动运行docker【当出问题时，docker正常时别用】

```shell
/var/packages/Docker/target/usr/bin/dockerd --config-file /var/packages/Docker/etc/dockerd.json
```

#### 一些重要文件路径：

```shell
/var/packages/Docker/conf/upstart/pkg-Docker-dockerd.conf
/var/packages/Docker/scripts/start-stop-status
/usr/syno/etc.defaults/iptables_modules_list
```



## 附注：如果你想运行DDSM那么修改start-stop-status文件

