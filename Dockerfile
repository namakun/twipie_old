# ==========================
# ベースステージ (PHP + Node.js)
# ==========================
FROM php:8.2-fpm AS base

# 必要パッケージをインストール
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

# PHP拡張をインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composer のコピー
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Node.js (20.x 系) をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# エントリポイントスクリプトを配置
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chown -R www-data:www-data /var/www/html

# ==========================
# 開発環境ステージ
# ==========================
FROM base AS development

# Nginx をインストール
RUN apt-get update && apt-get install -y nginx

# アプリコードをコピー
COPY . /var/www/html

# 開発用 Nginx 設定
COPY ./nginx/conf.d/default-dev.conf /etc/nginx/conf.d/default.conf

# PHP/Laravel & Node の依存関係をインストール
RUN composer install --prefer-dist --no-interaction
RUN npm install

EXPOSE 80 5173

# すべて同時に起動（Vite + PHP-FPM + Nginx）
ENTRYPOINT ["entrypoint.sh"]
CMD ["sh", "-c", "npm run dev & php-fpm & nginx -g 'daemon off;'"]

# ==========================
# ビルド専用ステージ (本番アーティファクト生成)
# ==========================
FROM base AS builder

COPY . /var/www/html

# 本番用のビルド（composerは--no-dev、npmはビルドタスク実行）
RUN composer install --optimize-autoloader --no-dev --no-interaction
RUN npm install
RUN npm run build

# ==========================
# 本番環境ステージ
# ==========================
FROM base AS production

# Nginx をインストール
RUN apt-get update && apt-get install -y nginx

# ビルド済みのファイルをコピー
COPY --from=builder /var/www/html /var/www/html

# 本番用 Nginx 設定
COPY ./nginx/conf.d/default-prod.conf /etc/nginx/conf.d/default.conf

# エントリポイントスクリプトを再度配置（builder からコピーでも可）
COPY --from=builder /usr/local/bin/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]
