#!/bin/sh

# 環境変数に応じて Composer のインストールオプションを設定
if [ "$APP_ENV" = "production" ]; then
    composer install --optimize-autoloader --no-dev --no-interaction
else
    composer install --prefer-dist --no-interaction
fi

# 環境変数に応じて NPM のインストールおよびビルドを設定
if [ "$APP_ENV" != "production" ]; then
    npm install
    npm run dev &
else
    npm install
    npm run build
fi

# ストレージおよびキャッシュディレクトリのパーミッション設定
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# PHP-FPM を起動
exec "$@"
