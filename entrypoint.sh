#!/bin/sh

# エラーが発生したら停止
set -e

echo "Starting container in $APP_ENV environment"

# 環境ごとに composer install を実行
if [ "$APP_ENV" = "production" ]; then
    echo "Running composer install for production..."
    composer install --optimize-autoloader --no-dev --no-interaction
else
    echo "Running composer install for development..."
    composer install --prefer-dist --no-interaction
fi

# Laravelキャッシュ関連のコマンド
if [ "$APP_ENV" = "production" ]; then
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
else
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
fi

# ストレージとキャッシュディレクトリの権限設定
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# PHP-FPM を起動
exec "$@"
