# ベースイメージ
FROM node:20-alpine AS builder

# 作業ディレクトリを作成
WORKDIR /var/www/html

# 必要なファイルをコピー
COPY package.json package-lock.json ./
COPY resources ./resources
COPY vite.config.js ./

# 依存関係をインストールしてビルド
RUN npm install
RUN npm run build

# 本番用のNginxイメージ
FROM nginx:alpine AS production

# Nginx設定をコピー
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# ビルドしたファイルをNginxの公開ディレクトリにコピー
COPY --from=builder /var/www/html/public /var/www/html/public

# Nginxを起動
CMD ["nginx", "-g", "daemon off;"]
