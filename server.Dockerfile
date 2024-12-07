# ベースイメージとして Nginx を使用
FROM nginx:alpine AS base

# 共通の設定ファイルを追加
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# 開発ステージ
FROM base AS development

CMD ["nginx", "-g", "daemon off;"]

# 本番ステージ
FROM base AS production

COPY ./public /var/www/html/public

CMD ["nginx", "-g", "daemon off;"]
