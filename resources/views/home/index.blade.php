<!-- resources/views/home.blade.php -->

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>トップページ</title>
</head>
<body>
    <h1>トップページ</h1>
    <p>ここにアプリの紹介や利用案内などを表示します。</p>

    <!-- ログインボタン誘導 -->
    <div>
        <a href="{{ route('login') }}">ログイン画面へ</a>
    </div>
</body>
</html>
