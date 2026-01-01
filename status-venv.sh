#!/bin/bash
# 闲鱼自动回复系统 - venv 状态查看脚本

cd /root/xianyu-auto-reply

echo "📊 闲鱼自动回复系统状态"
echo "================================"

# 检查虚拟环境
if [ -d "venv" ]; then
    echo "✅ 虚拟环境: 已创建"
    PYTHON_VERSION=$(venv/bin/python3 --version 2>&1)
    echo "   Python版本: $PYTHON_VERSION"
else
    echo "❌ 虚拟环境: 不存在"
fi

echo ""

# 检查进程
if ps aux | grep "venv/bin/python3 Start.py" | grep -v grep > /dev/null; then
    PID=$(ps aux | grep "venv/bin/python3 Start.py" | grep -v grep | awk '{print $2}')
    CPU=$(ps aux | grep "venv/bin/python3 Start.py" | grep -v grep | awk '{print $3}')
    MEM=$(ps aux | grep "venv/bin/python3 Start.py" | grep -v grep | awk '{print $4}')
    UPTIME=$(ps -p $PID -o etime= | tr -d ' ')

    echo "✅ 服务状态: 运行中"
    echo "   PID: $PID"
    echo "   CPU: $CPU%"
    echo "   MEM: $MEM%"
    echo "   运行时间: $UPTIME"
else
    echo "❌ 服务状态: 未运行"
fi

echo ""

# 检查端口
if netstat -tlnp 2>/dev/null | grep ":8080" | grep "venv/bin/pyt" > /dev/null; then
    echo "✅ 端口 8080: 已监听"
    echo "   访问地址: http://localhost:8080"
elif netstat -tlnp 2>/dev/null | grep ":8080" > /dev/null; then
    echo "⚠️  端口 8080: 已被其他进程占用"
else
    echo "❌ 端口 8080: 未监听"
fi

echo ""
echo "================================"
echo "📝 快捷命令:"
echo "   启动服务: ./start-venv.sh"
echo "   停止服务: ./stop-venv.sh"
echo "   查看日志: tail -f /root/xianyu-auto-reply-venv.log"
echo "   重启服务: ./stop-venv.sh && ./start-venv.sh"
