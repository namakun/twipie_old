<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <!-- タイトルをAPP_NAMEに基づき日本語化 -->
        <title>{{ config('app.name', 'Laravelアプリ') }}</title>

        <!-- フォント設定 -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=Noto+Sans+JP:wght@400;500;700&display=swap" rel="stylesheet" />

        <!-- スタイル・スクリプト -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="font-sans antialiased bg-gray-100">
        <div class="min-h-screen">
            <!-- ナビゲーションバー -->
            @include('layouts.navigation')

            <!-- ページのヘッダー -->
            @isset($header)
                <header class="bg-white shadow">
                    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 text-gray-800">
                        {{ $header }}
                    </div>
                </header>
            @endisset

            <!-- ページコンテンツ -->
            <main class="py-8 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
                {{ $slot }}
            </main>
        </div>
    </body>
</html>
