export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
    server: {
        host: '0.0.0.0', // 全てのネットワークインターフェースで接続を許可
        port: 5173,      // 使用するポート
    },
});
