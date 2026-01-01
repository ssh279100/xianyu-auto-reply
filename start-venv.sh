#!/bin/bash
# 闲鱼自动回复系统 - venv 启动脚本

cd /root/xianyu-auto-reply

echo "🚀 使用虚拟环境启动闲鱼自动回复系统..."

# 检查虚拟环境是否存在
if [ ! -d "venv" ]; then
    echo "❌ 虚拟环境不存在，请先运行: python3 -m venv venv"
    exit 1
fi

# 停止旧的进程
echo "🛑 停止旧的进程..."
pkill -f "venv/bin/python3 Start.py" 2>/dev/null

# 等待进程完全停止
sleep 2

# 启动服务
echo "✅ 启动服务..."
nohup venv/bin/python3 Start.py > /root/xianyu-auto-reply-venv.log 2>&1 &

# 等待服务启动
sleep 3

# 检查进程是否运行
if ps aux | grep "venv/bin/python3 Start.py" | grep -v grep > /dev/null; then
    PID=$(ps aux | grep "venv/bin/python3 Start.py" | grep -v grep | awk '{print $2}')
    echo "✅ 服务启动成功！"
    echo "   PID: $PID"
    echo "   日志: /root/xianyu-auto-reply-venv.log"
    echo "   访问: http://localhost:8080"
    echo ""
    echo "查看日志: tail -f /root/xianyu-auto-reply-venv.log"
else
    echo "❌ 服务启动失败，请检查日志: tail -f /root/xianyu-auto-reply-venv.log"
    exit 1
fi
