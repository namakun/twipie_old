<x-guest-layout>
    <div class="bg-gray-100 flex items-center justify-center">
        <div class="bg-white rounded-lg p-8 w-full max-w-md">
            <!-- ヘッダー部分 -->
            <div class="text-center mb-6">
                <img src="{{ app()->environment('production') ? secure_asset('twipie.png') : asset('twipie.png') }}" alt="twipie" class="w-24 mx-auto mb-4">
                <h1 class="text-3xl font-bold text-gray-800">Twipie (ツイパイ)</h1>
                <p class="text-gray-600">SNS運用をスマートに</p>
            </div>

            <!-- ログイン部分 -->
            <div class="text-center">
                <p class="text-gray-600 mb-4">Googleアカウントでログイン</p>
                <a href="{{ route('login.google') }}">
                    <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png"
                         alt="Sign in with Google" class="mx-auto">
                </a>
            </div>
        </div>
    </div>
</x-guest-layout>
