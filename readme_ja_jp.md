# このレポはsynologyのdockerがipv6訪問を出来ない問題を直す。

## 重要な前提: 

```shell
このprojectの検証条件は以下です
synology_apollolake_918+ DSM 6.2.3-25426
docker version: 20.10.3-0554
```

#### 1.dockerの配置を変える

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

#### 2.以下のコードをパソコンに入れる

```shell
git clone -b master --single-branch https://github.com/wangliangliang2/fix_synology_docker_ipv6.git
cd fix_synology_docker_ipv6
chmod +x fix.sh
./fix.sh
```

#### 3.ipv6 検証

```shell
docker run --rm -it busybox ping -6 -c4 ipv6-test.com
```



### dockerのバーションは18.09.0-0519です，自分で以下のコードをパソコンに入れる：

```shell
ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
```

#### 自分でdockerを実行します.【別の問題をおこる時しかしません】

```shell
/var/packages/Docker/target/usr/bin/dockerd --config-file /var/packages/Docker/etc/dockerd.json
```

#### 重要なファイル：

```shell
/var/packages/Docker/conf/upstart/pkg-Docker-dockerd.conf
/var/packages/Docker/scripts/start-stop-status
/usr/syno/etc.defaults/iptables_modules_list
```



## 別の話：DDSMを実行したいときstart-stop-statusを変える

