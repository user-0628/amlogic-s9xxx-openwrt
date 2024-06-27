#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
rm -rf package/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
#
# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# 添加vssr&ssr-plus&passwall
git_sparse_clone master https://github.com/xiangfeidexiaohuo/extra-ipk patch/wall-luci/luci-app-vssr
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb #vssr 依赖

git clone --depth=1 https://github.com/fw876/helloworld.git
cp -rf helloworld/luci-app-ssr-plus package/luci-app-ssr-plus
#cp -rf helloworld/chinadns-ng package/chinadns-ng
#cp -rf helloworld/dns2socks package/dns2socks
#cp -rf helloworld/dns2tcp package/dns2tcp
#cp -rf helloworld/gn package/gn
#cp -rf helloworld/hysteria package/hysteria
#cp -rf helloworld/ipt2socks package/ipt2socks
cp -rf helloworld/lua-neturl package/lua-neturl
#cp -rf helloworld/microsocks package/microsocks
#cp -rf helloworld/naiveproxy package/naiveproxy
cp -rf helloworld/redsocks2 package/redsocks2
cp -rf helloworld/shadow-tls package/shadow-tls
#cp -rf helloworld/shadowsocks-rust package/shadowsocks-rust
#cp -rf helloworld/shadowsocksr-libev package/shadowsocksr-libev
#cp -rf helloworld/simple-obfs package/simple-obfs
#cp -rf helloworld/tcping package/tcping
#cp -rf helloworld/trojan package/trojan
cp -rf helloworld/tuic-client package/tuic-client
#cp -rf helloworld/v2ray-core package/v2ray-core
#cp -rf helloworld/v2ray-geodata package/v2ray-geodata
#cp -rf helloworld/v2ray-plugin package/v2ray-plugin
#cp -rf helloworld/v2raya package/v2raya
#cp -rf helloworld/xray-core package/xray-core
#cp -rf helloworld/xray-plugin package/xray-plugin
rm -rf helloworld

git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git  package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git  package/luci-app-passwall2

git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git
cp -rf openwrt-passwall-packages/brook package/brook
cp -rf openwrt-passwall-packages/chinadns-ng package/chinadns-ng
cp -rf openwrt-passwall-packages/dns2socks package/dns2socks
cp -rf openwrt-passwall-packages/dns2tcp package/dns2tcp
cp -rf openwrt-passwall-packages/gn package/gn
cp -rf openwrt-passwall-packages/hysteria package/hysteria
cp -rf openwrt-passwall-packages/ipt2socks package/ipt2socks
cp -rf openwrt-passwall-packages/microsocks package/microsocks
cp -rf openwrt-passwall-packages/naiveproxy package/naiveproxy
#cp -rf openwrt-passwall-packages/pdnsd-alt package/pdnsd-alt #与lean重复feeds/packages/net
cp -rf openwrt-passwall-packages/shadowsocks-rust package/shadowsocks-rust
cp -rf openwrt-passwall-packages/shadowsocksr-libev package/shadowsocksr-libev
cp -rf openwrt-passwall-packages/simple-obfs package/simple-obfs
cp -rf openwrt-passwall-packages/sing-box package/sing-box
cp -rf openwrt-passwall-packages/ssocks package/ssocks
cp -rf openwrt-passwall-packages/tcping package/tcping
cp -rf openwrt-passwall-packages/trojan-go package/trojan-go
cp -rf openwrt-passwall-packages/trojan-plus package/trojan-plus
cp -rf openwrt-passwall-packages/trojan package/trojan
cp -rf openwrt-passwall-packages/tuic-client package/tuic-client
cp -rf openwrt-passwall-packages/v2ray-core package/v2ray-core
#cp -rf openwrt-passwall-packages/v2ray-geodata package/v2ray-geodata #与lean重复feeds/packages/net
cp -rf openwrt-passwall-packages/v2ray-plugin package/v2ray-plugin
cp -rf openwrt-passwall-packages/xray-core package/xray-core
cp -rf openwrt-passwall-packages/xray-plugin package/xray-plugin
rm -rf openwrt-passwall-packages


# ------------------------------- Other ends -------------------------------

