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

# https://github.com/StarWhiz/NanoPi-R6S-CPU-Optimization-for-Gigabit-SQM/tree/main/R4S%20CPU%20Optimization
echo '### IRQ 调优 ###'
sed -i 's/sharevdi,guangmiao-g4c/friendlyelec,nanopi-r4s/' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i 's/set_interface_core 10 "eth0"/set_interface_core 4 "eth0"/' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i 's/set_interface_core 20 "eth1"/set_interface_core 8 "eth1"/' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/set_interface_core 8 "eth1"/a\        echo -n 10 > /sys/class/net/eth0/queues/rx-0/rps_cpus\n        echo -n 20 > /sys/class/net/eth1/queues/rx-0/rps_cpus' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
echo '###  ###'
