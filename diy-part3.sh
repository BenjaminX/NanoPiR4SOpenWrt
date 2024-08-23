echo '### 修复 luci-app-syncdial 检测的 bug ###'
sed -i 's/is online and tracking is active/and tracking is active/' target/linux/rockchip/armv8/base-files/usr/lib/lua/luci/model/cbi/syncdial.lua
echo '###  ###'