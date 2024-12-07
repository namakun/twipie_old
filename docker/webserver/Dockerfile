# ベースイメージとしてNGINXを使用
FROM nginx:alpine

# NGINXの設定ファイルをコンテナ内にコピー
COPY ./docker/webserver/nginx/conf.d/default.conf /etc/nginx/conf.d/
# Laravelの公開ディレクトリをコピー
COPY ./public /var/www/html/public

# ドキュメントルート用のディレクトリを設定
WORKDIR /var/www/html
