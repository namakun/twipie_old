<div class="bg-green-200 text-black p-4">
    Tailwindが動作しています。
</div>

<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('プロフィール') }}
        </h2>
    </x-slot>

    <div class="py-12 bg-gray-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
            <!-- プロフィール情報の更新 -->
            <div class="p-6 bg-white shadow rounded-lg border border-gray-300">
                <div class="max-w-xl">
                    @include('profile.partials.update-profile-information-form')
                </div>
            </div>

            <!-- パスワードの変更 -->
            <div class="p-6 bg-white shadow rounded-lg border border-gray-300">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    パスワードの変更
                </h3>
                <div class="max-w-xl">
                    @include('profile.partials.update-password-form')
                </div>
            </div>

            <!-- ログアウトボタン -->
            <div class="p-6 bg-white shadow rounded-lg border border-gray-300">
                <h3 class="text-lg font-medium text-gray-900 mb-4">
                    ログアウト
                </h3>
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">
                        ログアウト
                    </button>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
