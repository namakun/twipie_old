<!-- 現在は新規登録を受け付けない方針なので、空 or SSO誘導のみなどに修正 -->

<x-guest-layout>
    <div class="mt-8">
        <p>このアプリはGoogleアカウントでのみ登録可能です。</p>
        <div class="flex items-center justify-center mt-4">
            <a href="{{ route('login.google') }}">
                <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png"
                     alt="Sign in with Google">
            </a>
        </div>
    </div>
</x-guest-layout>
