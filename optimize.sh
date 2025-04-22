#!/bin/bash

echo "📦 VPSOptimizer 正在运行..."
echo "🔍 正在检测是否支持 BBRv3..."

kernel_version=$(uname -r)

if [[ "$kernel_version" =~ "5.15" || "$kernel_version" =~ "6." ]]; then
    echo "✅ 当前内核版本 $kernel_version 支持 BBRv3"
else
    echo "⚠️ 当前内核版本可能不支持 BBRv3，请考虑升级"
fi

echo "📥 设置 sysctl 网络优化参数..."
cat >> /etc/sysctl.conf <<EOF

# VPSOptimizer 自动优化参数
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_forward = 1

EOF

sysctl -p

echo "📡 安装网络测速工具 iperf3"
apt update && apt install -y iperf3

echo "✅ 优化完成！你可以用 iperf3 测试网络性能了。"
