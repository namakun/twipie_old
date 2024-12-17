# ベースイメージ（PHP + Node.jsを含む）
FROM php:8.2-fpm AS base

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP拡張のインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerの追加
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Entrypoint
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN chown -R www-data:www-data /var/www/html

# 本番用ビルドステージ
FROM base AS builder

# composer.json と composer.lock を先にコピー
COPY composer.json composer.lock /var/www/html/

# 依存関係のインストール
RUN composer install --optimize-autoloader --no-dev --no-interaction --no-scripts

# アプリケーションコードをコピー
COPY . /var/www/html

# フロントエンドのビルド
RUN npm install
RUN npm run build

# 本番用ステージ
FROM base AS production

# Nginx設定を追加
COPY ./nginx/conf.d/default-prod.conf /etc/nginx/conf.d/default.conf

# アプリケーションコードを追加
COPY --from=builder /var/www/html /var/www/html

# 公開ポート
EXPOSE 80

# NginxとPHP-FPMの起動
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]
