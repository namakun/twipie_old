# ベースイメージとしてNGINXを使用
FROM nginx:alpine

# NGINXの設定ファイルをコンテナ内にコピー
COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Laravelの公開ディレクトリをコピー
COPY ./public /var/www/html/public

# ドキュメントルート用のディレクトリを設定
WORKDIR /var/www/html
