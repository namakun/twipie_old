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

# 開発用ステージ
FROM base AS development

# 必要なファイルをコピー
COPY . /var/www/html

# Nginxの追加
RUN apt-get update && apt-get install -y nginx
COPY ./nginx/conf.d/default-dev.conf /etc/nginx/conf.d/default.conf

# 依存関係のインストール
RUN composer install --prefer-dist --no-interaction
RUN npm install

# ポート公開
EXPOSE 80 5173

# Nginx、PHP-FPM、Viteを同時に起動
CMD ["sh", "-c", "php-fpm & npm run dev & nginx -g 'daemon off;'"]

# 本番用ビルドステージ
FROM base AS builder

# 必要なファイルをコピー
COPY . /var/www/html

# 本番用の依存関係インストールとビルド
RUN composer install --optimize-autoloader --no-dev --no-interaction
RUN npm install
RUN npm run build

# 本番用ステージ
FROM nginx:alpine AS production

# Nginx設定をコピー
COPY ./nginx/conf.d/default-prod.conf /etc/nginx/conf.d/default.conf

# PHP-FPM用の設定
COPY --from=builder /var/www/html /var/www/html
COPY --from=builder /usr/local/bin/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 公開ポート
EXPOSE 80

# Entrypointの実行
ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
