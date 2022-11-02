#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
echo '### Updates default IP gate ###'
sed -i 's/192.168.1.1/10.1.1.10/g' package/base-files/files/bin/config_generate
echo '###  ###'

# Modify kernel version
# echo '### Updates kernel version ###'
# sed -i 's/KERNEL_PATCHVER=5.19/KERNEL_PATCHVER=5.15/g' target/linux/rockchip/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER=5.4/KERNEL_TESTING_PATCHVER=5.19/g' target/linux/rockchip/Makefile
# echo '###  ###'

# echo '### Updates Theme Argon ###'
# package/lean/luci-theme-argon /package/feeds/luci/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/feeds/luci/luci-theme-argon
echo '###  ###'

# echo '### 添加 R4S GPU 驱动 ###'
# rm -rf package/kernel/linux/modules/video.mk
# wget -P package/kernel/linux/modules/ https://raw.githubusercontent.com/immortalwrt/immortalwrt/master/package/kernel/linux/modules/video.mk
# echo '###  ###'

# echo '### 使用特定的优化 ###'
# sed -i 's,-mcpu=generic,-mcpu=cortex-a72.cortex-a53+crypto,g' include/target.mk
# cp -f $GITHUB_WORKSPACE/PATCH/mbedtls/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
# sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/rockchip/image/armv8.mk
# echo '###  ###'

echo '### CacULE ###'
sed -i '/CONFIG_NR_CPUS/d' ./target/linux/rockchip/armv8/config-5.4
echo '
CONFIG_NR_CPUS=6
' >> ./target/linux/rockchip/armv8/config-5.4
echo '###  ###'

echo '### UKSM ###'
echo '
CONFIG_KSM=y
CONFIG_UKSM=y
' >> ./target/linux/rockchip/armv8/config-5.4
echo '###  ###'

# echo '### IRQ 调优 ###'
# sed -i '/set_interface_core 20 "eth1"/a\set_interface_core 8 "ff3c0000" "ff3c0000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
# sed -i '/set_interface_core 20 "eth1"/a\ethtool -C eth0 rx-usecs 1000 rx-frames 25 tx-usecs 100 tx-frames 25' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
# echo '###  ###'
