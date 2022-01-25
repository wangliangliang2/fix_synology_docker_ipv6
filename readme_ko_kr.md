synology docker ipv6을 고치 하겠습니다
```shell
그 다음 조건에 확인했습니다
synology_apollolake_918+ DSM 6.2.3-25426
docker version: 20.10.3-0554
```

먼저 설치 서류에 이렇게 적습니다
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

그 다음에 이렇게 합니다
```shell
git clone -b master --single-branch https://github.com/wangliangliang2/fix_synology_docker_ipv6.git
cd fix_synology_docker_ipv6
chmod +x fix.sh
./fix.sh
```

마지막 이렇게 확인합니다
```shell
docker run --rm -it busybox ping -6 -c4 ipv6-test.com
```
