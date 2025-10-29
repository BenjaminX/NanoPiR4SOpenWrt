#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/sbwml/openwrt_helloworld.git;v5' >>feeds.conf.default
# echo 'src-git helloworld https://github.com/fw876/helloworld.git;master' >>feeds.conf.default
echo '### SSR helloworld ###'
# echo "src-git oui https://github.com/zhaojh329/oui.git" >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
echo '### Argon Theme Config ###'

git clone https://github.com/esirplayground/luci-app-poweroff.git package/lean/luci-app-poweroff
echo '### Shutdown Router ###'

git clone https://github.com/BenjaminX/luci-app-syncdial.git package/lean/luci-app-syncdial
echo '### luci-app-syncdial ###'

# 移除 openwrt feeds 自带的核心包
# rm -rf feeds/packages/net/{libustream-mbedtls20201210}
# git clone https://github.com/sbwml/openwrt_helloworld package/helloworld

# 更新 golang 1.23 版本
# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
