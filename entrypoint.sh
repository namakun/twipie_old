#!/bin/sh

# エラーが発生したら停止
set -e

echo "Starting container in $APP_ENV environment"

# 環境変数のチェック（デバッグ用）
echo "APP_ENV=${APP_ENV}"
echo "APP_KEY=${APP_KEY}"
echo "APP_URL=${APP_URL}"

# 本番環境で .env が存在しない場合は自動作成
if [ "$APP_ENV" = "production" ] && [ ! -f /var/www/html/.env ]; then
    echo "Generating .env file from .env.example"
    cp /var/www/html/.env.example /var/www/html/.env

    # 環境変数を適用
    sed -i "s|^APP_ENV=.*|APP_ENV=${APP_ENV}|g" /var/www/html/.env
    sed -i "s|^APP_KEY=.*|APP_KEY=${APP_KEY}|g" /var/www/html/.env
    sed -i "s|^APP_URL=.*|APP_URL=${APP_URL}|g" /var/www/html/.env
    sed -i "s|^ASSET_URL=.*|ASSET_URL=${ASSET_URL}|g" /var/www/html/.env
    sed -i "s|^DB_HOST=.*|DB_HOST=${DB_HOST}|g" /var/www/html/.env
    sed -i "s|^DB_PORT=.*|DB_PORT=${DB_PORT}|g" /var/www/html/.env
    sed -i "s|^DB_DATABASE=.*|DB_DATABASE=${DB_DATABASE}|g" /var/www/html/.env
    sed -i "s|^DB_USERNAME=.*|DB_USERNAME=${DB_USERNAME}|g" /var/www/html/.env
    sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD}|g" /var/www/html/.env
    sed -i "s|^GOOGLE_KEY=.*|GOOGLE_KEY=${GOOGLE_KEY}|g" /var/www/html/.env
    sed -i "s|^GOOGLE_SECRET=.*|GOOGLE_SECRET=${GOOGLE_SECRET}|g" /var/www/html/.env
    sed -i "s|^GOOGLE_REDIRECT_URI=.*|GOOGLE_REDIRECT_URI=${GOOGLE_REDIRECT_URI}|g" /var/www/html/.env
fi

# キャッシュ用ディレクトリの作成
mkdir -p /var/www/html/storage/framework/cache /var/www/html/storage/framework/views

# 環境ごとの設定
if [ "$APP_ENV" = "production" ]; then
    echo "Running production setup..."
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
else
    echo "Running development setup..."
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
fi

# パーミッションの設定
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# 最後に CMD (または docker run の引数) を実行
exec "$@"
