#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/luci-theme-argon
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf ./package/lean/luci-theme-opentomcat
rm -rf ./feeds/packages/net/smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns
rm -rf ./package/lean/luci-app-netdata
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/lean/luci-app-netdata
rm -rf ./feeds/packages/net/https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy
rm -rf ./package/lean/autocore
rm -rf ./package/lean/default-settings
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)-Ipv6/g' include/image.mk
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
echo "DISTRIB_REVISION='S$(TZ=UTC-8 date +%Y.%m.%d) Sirpdboy Ipv6'" > ./package/base-files/files/etc/openwrt_release1
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
# svn co https://github.com/siropboy/luci-app-vssr-plus/trunk/luci-app-vssr-plus package/new/luci-app-vssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr
./scripts/feeds update -i
