import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/css/loader.css',
                'resources/css/sidebar.css',
                'resources/js/app.js',
                'resources/js/bootstrap.js',
                'resources/js/loader.js',
                'resources/js/sidebar.js',
            ],
            refresh: true,
        }),
    ],
});
