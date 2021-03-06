#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/luci-theme-argon
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin
rm -rf ./package/lean/luci-theme-opentomcat
rm -rf ./package/lean/ddns-scripts_aliyun
rm -rf ./package/lean/ddns-scripts_dnspod
# echo '替换aria2'
rm -rf feeds/luci/applications/luci-app-aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-aria2 feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/aria2 feeds/packages/net/aria2
rm -rf feeds/packages/net/ariang && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/ariang feeds/packages/net/ariang
# echo '替换transmission'
rm -rf feeds/luci/applications/luci-app-transmission && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-transmission feeds/luci/applications/luci-app-transmission
rm -rf feeds/packages/net/transmission && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/transmission feeds/packages/net/transmission
rm -rf feeds/packages/net/transmission-web-control && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/transmission-web-control feeds/packages/net/transmission-web-control
# echo 'qBittorrent'
sed -i 's/+qbittorrent/+qbittorrent +python3/g' ./package/lean/luci-app-qbittorrent/Makefile
rm -rf package/lean/luci-app-qbittorrent
rm -rf package/lean/qt5
rm -rf package/lean/qBittorrent
echo '替换smartdns'
rm -rf ./feeds/packages/net/smartdns&& \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./package/diy/smartdns
rm -rf ./package/lean/luci-app-netdata && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/lean/luci-app-netdata
rm -rf ./feeds/packages/admin/netdata && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./feeds/packages/admin/netdata
rm -rf ./feeds/packages/net/mwan3 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/mwan3 ./feeds/packages/net/mwan3
rm -rf ./feeds/packages/net/https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy
#rm -rf ./package/diy/autocore
#rm -rf ./package/diy/default-settings
rm -rf ./package/diy/automount
rm -rf ./package/diy/autosamba
rm -rf ./package/diy/luci-app-cpufreq
rm -rf ./package/diy/luci-app-ipsec-vpnd
rm -rf ./package/lean/luci-app-wrtbwmon
rm -rf ./package/diy/samba4
#rm -rf package/lean/luci-app-samba4
rm -rf ./package/diy/luci-app-samba4
rm -rf ./package/diy/netdata
rm -rf ./package/diy/mwan3
rm -rf ./package/diy/autocore
rm -rf ./package/lean/default-settings

#curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/x86/index.htm > package/lean/autocore/files/x86/index.htm
#curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/arm/index.htm > package/lean/autocore/files/arm/index.htm
#curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/default-settings/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.luased -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/ACC网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/解锁网易云灰色歌曲/解锁灰色歌曲/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/家庭云//g' package/lean/luci-app-familycloud/luasrc/controller/familycloud.lua
cp -f ./package/diy/banner ./package/base-files/files/etc/
date1='S'`TZ=UTC-8 date +%Y.%m.%d -d +"0"days`
sed -i 's/$(VERSION_DIST_SANITIZED)/$(shell TZ=UTC-8 date +%Y%m%d)/g' include/image.mk
echo "DISTRIB_REVISION='${date1} by Siropboy'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by Siropboy ' >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner
sed -i 's/invalid/# invalid/g' package/lean/samba4/files/smb.conf.template
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow
#sed -i 's/tables=1/tables=0/g' ./package/kernel/linux/files/sysctl-br-netfilter.conf
echo  "        option tls_enable 'true'" >> ./package/lean/luci-app-frpc/root/etc/config/frp
# sed -i '/filter_/d' package/network/services/dnsmasq/files/dhcp.conf
#内核设置
##sed -i '/CONFIG_NVME_MULTIPATH /d' ./package/target/linux/x86/config-5.4
#sed -i '/CONFIG_NVME_TCP /d' ./package/target/linux/x86/config-5.4
#echo  'CONFIG_BINFMT_MISC=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_EXTRA_FIRMWARE="i915/kbl_dmc_ver1_04.bin"'   >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"'  >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_FABRICS=y'  >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_FC=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_MULTIPATH=y' >> ./package/target/linux/x86/config-5.4
#echo  'CONFIG_NVME_TCP=y' >> ./package/target/linux/x86/config-5.4
git clone https://github.com/garypang13/luci-app-dnsfilter.git package/diy/luci-app-dnsfilter
#luci-app-jd-dailybonus
rm -rf package/lean/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/diy/luci-app-jd-dailybonus
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/diy/luci-app-openclash
git clone https://github.com/xiaorouji/openwrt-passwall package/diy1
#git clone https://github.com/AlexZhuo/luci-app-bandwidthd /package/diy/luci-app-bandwidthd
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
#bypass
git clone -b master --single-branch https://github.com/fw876/helloworld ./package/hw
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr
#git clone https://github.com/garypang13/luci-app-bypass.git package/diy/luci-app-bypass
#sed -i 's/shadowsocksr-libev-alt/shadowsocksr-libev-ssr-redir/g' package/*/*/Makefile
#sed -i 's/shadowsocksr-libev-server/shadowsocksr-libev-ssr-server/g' package/*/*/Makefile
svn co https://github.com/jerrykuku/luci-app-ttnode/trunk/  package/diy/luci-app-ttnode
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#sed -i "/mediaurlbase/d" package/*/luci-theme*/root/etc/uci-defaults/*
#sed -i "/mediaurlbase/d" feed/*/luci-theme*/root/etc/uci-defaults/*
# rm -rf ./package/diy1/trojan
# rm -rf ./package/diy1/v2ray
# rm -rf ./package/diy1/v2ray-plugin
#  git clone https://github.com/openwrt-dev/po2lmo.git package/diy/po2lmo
#  cd package/diy/po2lmo
#  make && sudo make install
#  rm -rf package/lean/luci-app-dockerman
#  rm -rf package/lean/luci-lib-docker
#  rm -rf package/lean/luci-app-diskman
#  rm -rf package/lean/parted
rm -rf package/diy/luci-app-dockerman
rm -rf package/diy/luci-lib-docker
rm -rf package/hw/xray-core
rm -rf package/diy1/tcping
#rm -rf package/diy1/xray-core
#rm -rf package/diy/vssr
./scripts/feeds update -i
