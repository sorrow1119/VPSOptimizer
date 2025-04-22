# VPSOptimizer

一个开源的一键 VPS 网络优化工具箱，支持自动开启 BBRv3、网络 sysctl 参数优化、测速工具安装，并输出优化报告。

## 功能
- 自动检测内核版本，尝试启用 BBRv3
- 应用推荐的网络优化参数
- 安装 iperf3 进行测速
- 更多功能即将添加...

## 使用方法

```bash
bash <(curl -Ls https://raw.githubusercontent.com/你的用户名/VPSOptimizer/main/optimize.sh)
## 致谢

本项目由 [VTEXS] 提供免费 VPS 赞助支持，感谢他们对开源社区的支持。
# VPSOptimizer

[VPSOptimizer](https://github.com/sorrow1119/VPSOptimizer) is an open-source tool that automates the process of enabling network optimizations on Linux VPS using the BBRv3 congestion control algorithm. It simplifies kernel compilation and applies the BBRv3 settings to enhance network throughput and reduce latency.

## Features
- Automates the installation of the BBRv3 kernel module on Linux systems.
- Provides a simple shell script for quick setup.
- Supports Ubuntu 22.04 and other compatible distributions.
  
## Installation
1. Clone this repository to your server:
   ```bash
   git clone https://github.com/sorrow1119/VPSOptimizer.git
   cd VPSOptimizer
2.Make the script executable:使脚本可执行：
   ```bash
   chmod +x optimize.sh
3.Run the script:运行脚本：
  ```bash
  sudo ./optimize.sh
 
