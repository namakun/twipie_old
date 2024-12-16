<!-- resources/views/login.blade.php (SSO専用) -->
<x-guest-layout>
    <div class="flex items-center justify-center mt-8">
        <a href="{{ route('login.google') }}">
            <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png"
                 alt="Sign in with Google">
        </a>
    </div>
</x-guest-layout>
