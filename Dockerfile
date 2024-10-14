# ベースイメージとしてPHP 8.2-FPMを使用
FROM php:8.2-fpm

# システムパッケージのインストール
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

# PHP拡張モジュールのインストール
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composerのインストール
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 作業ディレクトリを設定
WORKDIR /var/www/html

# パーミッションの設定
RUN chown -R www-data:www-data /var/www/html

# ポートの公開（必要に応じて）
EXPOSE 9000

# PHP-FPMを起動
CMD ["php-fpm"]
