#!/bin/bash
set -e

# 啟動 MySQL 服務
docker-entrypoint.sh mysqld &

# 等待 MySQL 完全啟動。您可以根據需要調整等待時間或條件
echo "Waiting for MySQL to start..."
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
    echo 'Waiting for the slave database to become available...'
    sleep 5
done

echo "MySQL slave started."

# 在這裏執行 init-slave.sh 腳本
echo "Running init-slave.sh script..."
/usr/local/bin/init-slave.sh

# 保持容器運行
wait $!
