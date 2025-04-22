#!/bin/bash

# VPSOptimizer - 一键优化你的 VPS 网络设置
# 作者: Wen Sun | GitHub: https://github.com/sorrow1119/VPSOptimizer

set -e

# 颜色输出
green() { echo -e "\033[32m$1\033[0m"; }
red() { echo -e "\033[31m$1\033[0m"; }

# 检查是否为 root 用户
if [[ $EUID -ne 0 ]]; then
  red "⚠️  请使用 root 用户运行此脚本！"
  exit 1
fi

green "✅ 开始执行 VPS 网络优化..."

# 检查内核版本
kernel_version=$(uname -r)
green "🧠 当前内核版本: $kernel_version"

# 启用 BBR（如果支持）
green "📦 启用 TCP BBR 拥塞控制算法..."
modprobe tcp_bbr || true
echo "tcp_bbr" > /etc/modules-load.d/bbr.conf
echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
sysctl -p

# 验证 BBR 是否启用成功
if [[ $(sysctl net.ipv4.tcp_congestion_control) == *"bbr"* ]]; then
  green "✅ BBR 已启用"
else
  red "❌ BBR 启用失败"
fi

# 添加基本网络优化参数
green "🚀 应用网络优化参数..."
cat <<EOF >> /etc/sysctl.conf

# VPS 网络优化参数
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 300
EOF
sysctl -p

# 安装常用测试工具
green "📥 安装 iperf3 用于带宽测试..."
apt update && apt install -y iperf3

green "🎉 优化完成！你可以使用 iperf3 -c 服务端IP 来测试带宽性能。"
