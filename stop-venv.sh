#!/bin/bash
# 闲鱼自动回复系统 - venv 停止脚本

cd /root/xianyu-auto-reply

echo "🛑 停止闲鱼自动回复系统..."

# 检查进程是否运行
if ps aux | grep "venv/bin/python3 Start.py" | grep -v grep > /dev/null; then
    PID=$(ps aux | grep "venv/bin/python3 Start.py" | grep -v grep | awk '{print $2}')
    echo "   找到进程 PID: $PID"

    # 停止进程
    pkill -f "venv/bin/python3 Start.py"

    # 等待进程完全停止
    sleep 2

    # 再次检查
    if ps aux | grep "venv/bin/python3 Start.py" | grep -v grep > /dev/null; then
        echo "❌ 进程未能正常停止，尝试强制停止..."
        pkill -9 -f "venv/bin/python3 Start.py"
        sleep 1
    fi

    # 最终检查
    if ps aux | grep "venv/bin/python3 Start.py" | grep -v grep > /dev/null; then
        echo "❌ 停止失败"
        exit 1
    else
        echo "✅ 服务已停止"
    fi
else
    echo "⚠️  服务未运行"
fi
