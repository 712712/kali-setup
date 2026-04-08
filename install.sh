echo "=================================="
echo "  Kali Linux 一键配置脚本"
echo "=================================="
echo ""

# 检查是否为root用户
if [ "$EUID" -ne 0 ]; then 
   echo "请用root权限运行: sudo ./install.sh"
   exit 1
fi

# 步骤1: 配置清华源（下载更快）
echo "[1/6] 正在配置清华镜像源..."
sudo tee /etc/apt/sources.list <<-'EOF'
# 清华源 Kali 镜像
deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
EOF
echo "✓ 源配置完成"

# 步骤2: 更新软件列表
echo "[2/6] 正在更新软件列表..."
apt update
echo "✓ 更新完成"

# 步骤3: 安装基础工具
echo "[3/6] 正在安装基础工具..."
apt install -y python3-pip git vim curl wget tmux
echo "✓ 基础工具安装完成"

# 步骤4: 安装渗透工具
echo "[4/6] 正在安装常用渗透工具..."
apt install -y nmap hydra sqlmap wireshark
echo "✓ 渗透工具安装完成"

# 步骤5: 开启SSH服务（方便远程连接）
echo "[5/6] 正在开启SSH服务..."
systemctl enable ssh
systemctl start ssh
echo "✓ SSH服务已开启"

# 步骤6: 创建常用文件夹
echo "[6/6] 正在创建工作目录..."
mkdir -p ~/tools ~/wordlists ~/results
echo "✓ 目录创建完成"

# 步骤7： 更新
apt update
apt full-upgrade -y
reboot
echo ""
echo "=================================="
echo " 配置完成！"
echo "=================================="
echo ""
echo "创建的目录："
echo "  ~/tools    - 放工具"
echo "  ~/wordlists - 放字典"
echo "  ~/results   - 放扫描结果"
echo ""
echo "如需重启: sudo reboot"

