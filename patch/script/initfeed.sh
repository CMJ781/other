#/bin/sh
# device_name='PDLEDE'      # �豸�����ŵ��˵����豸��sh�ļ�����
wifi_name="SirpdboyWIFI"       # Wifi ���� ,�ŵ��˵����豸��sh�ļ�����
lan_ip='192.168.1.1'        # Lan Ip��ַ
utc_name='Asia\/Shanghai'   # ʱ��
default_theme='opentopd'   # Ĭ������ ��������ļ�������
theme_pd='https://github.com/sirpdboy/luci-theme-opentopd'  # �����ַ

MovePkgsList="
./package/lean/luci-app-kodexplorer 
./package/lean/luci-lib-docker 
./package/lean/luci-app-dockerman 
./package/lean/luci-theme-argon 
./package/lean/luci-theme-opentomcat 
./package/lean/trojan 
./package/lean/luci-app-netdata 
./package/lean/autocore 
./package/lean/luci-app-vsftpd 
./package/lean/default-settings 
./package/lean/v2ray 
./package/lean/v2ray-plugin 
./feeds/packages/admin/netdata 
./feeds/packages/net/miniupnpd 
./feeds/packages/net/mwan3 
./feeds/packages/net/https-dns-proxy 
./feeds/packages/net/smartdns 
./feeds/packages/net/kcptun 
./feeds/luci/applications/luci-app-sqm
./feeds/luci/applications/luci-app-nlbwmon 
"

function MovePkg()
{
	if [ -d $1 ];then
		rm -rf $1
		echo $1" Disabled."
	fi
}

for disablePkg in $MovePkgsList
do
	MovePkg $disablePkg
done

# ����
# echo "�޸Ļ�������"
# sed -i "s/OpenWrt/$device_name/g" package/base-files/files/bin/config_generate

# echo "�޸�wifi����"
sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo "����lan ip"
sed -i "s/192.168.1.1/$lan_ip/g" package/base-files/files/bin/config_generate

echo "�޸�ʱ��"
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='$utc_name'/g" package/base-files/files/bin/config_generate

echo "�޸�Ĭ������"
sed -i "s/bootstrap/$default_theme/g" ./feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/bootstrap/$default_theme/g' ./feeds/luci/collections/luci/Makefile
sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(BUILD_DATE_PREFIX)-ipv6-/g' ./include/image.mk
echo "��ӹػ�"
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/default-settings/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_REVISION='S$(date +%Y.%m.%d) Sirpdboy'" > ./package/base-files/files/etc/openwrt_release1
./scripts/feeds update -i
