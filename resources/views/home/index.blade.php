<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Twipie - トップページ</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        header {
            text-align: center;
            margin-bottom: 30px;
        }
        header img {
            width: 100px;
            margin-bottom: 10px;
        }
        header h1 {
            font-size: 2rem;
            color: #222;
        }
        main {
            background: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            text-align: center;
        }
        main p {
            margin: 15px 0 25px;
            font-size: 1.1rem;
            line-height: 1.8;
        }
        main ul {
            text-align: left;
            margin: 15px 0;
            padding: 0;
            list-style-type: none;
        }
        main ul li {
            margin: 10px 0;
            padding-left: 20px;
            position: relative;
        }
        main ul li:before {
            content: "✔";
            color: #4CAF50;
            position: absolute;
            left: 0;
        }
        .login-btn {
            display: inline-block;
            text-decoration: none;
            color: #fff;
            background-color: #4CAF50;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .login-btn:hover {
            background-color: #45a049;
        }
        footer {
            margin-top: 30px;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>
<body>
    <header>
        <img src="{{ app()->environment('production') ? secure_asset('twipie.png') : asset('twipie.png') }}" alt="Twipie Logo">
        <h1>Twipie - SNS運用をスマートに</h1>
    </header>
    <main>
        <p>Twipieは、Twitterを活用したSNS運用を効率化するためのツールです。<br>
           以下の機能でSNS運用を支援します：</p>
        <ul>
            <li>投稿の自動化で時間を節約</li>
            <li>データ分析で投稿の効果を最大化</li>
            <li>フォロワーの管理とエンゲージメント強化</li>
        </ul>
        <a href="{{ route('login') }}" class="login-btn">ログインして始める</a>
    </main>
    <footer>
        &copy; {{ date('Y') }} Twipie. All rights reserved.
    </footer>
</body>
</html>
