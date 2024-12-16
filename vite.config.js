import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig(({ mode }) => {
    const isProduction = (mode === 'production');

    return {
        plugins: [
            laravel({
                input: ['resources/css/app.css', 'resources/js/app.js'],
                refresh: true,
                buildDirectory: 'build',
            }),
        ],
        server: {
            host: '0.0.0.0',
            port: 5173,
        },
        build: {
            manifest: true,
            outDir: 'public/build',
            emptyOutDir: true,
        },
        base: isProduction
            ? process.env.ASSET_URL || '/'
            : '/',
    };
}
);
