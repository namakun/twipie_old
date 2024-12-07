#!/bin/sh

# エラーが発生したら停止
set -e

echo "Starting container in $APP_ENV environment"

# 本番環境で .env が存在しない場合は作成
if [ ! -f /var/www/html/.env ]; then
    echo "Generating .env file from .env.example"
    cp /var/www/html/.env.example /var/www/html/.env

    # 必要に応じて環境変数を上書き
    # sed -i "s|APP_ENV=local|APP_ENV=${APP_ENV}|g" /var/www/html/.env
    sed -i "s|APP_KEY=|APP_KEY=${APP_KEY}|g" /var/www/html/.env
    # sed -i "s|DB_HOST=127.0.0.1|DB_HOST=${DB_HOST}|g" /var/www/html/.env
    # sed -i "s|DB_DATABASE=laravel|DB_DATABASE=${DB_DATABASE}|g" /var/www/html/.env
    # sed -i "s|DB_USERNAME=root|DB_USERNAME=${DB_USERNAME}|g" /var/www/html/.env
    # sed -i "s|DB_PASSWORD=|DB_PASSWORD=${DB_PASSWORD}|g" /var/www/html/.env
fi


# 環境ごとに composer install を実行
if [ "$APP_ENV" = "production" ]; then
    echo "Running composer install for production..."
    composer install --optimize-autoloader --no-dev --no-interaction
else
    echo "Running composer install for development..."
    composer install --prefer-dist --no-interaction
fi

mkdir -p /var/www/html/storage/framework/cache /var/www/html/storage/framework/views

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
