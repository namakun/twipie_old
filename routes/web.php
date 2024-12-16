<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\GoogleLoginController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

// トップページを表示
Route::get('/', function () {
    return view('home.index');
})->name('home');


// Loginページ（SSOのみ）
Route::get('/login', function () {
    return view('auth.login');
})->name('login');

// ダッシュボード画面（メール認証は不要なので 'verified' を削除）
Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth'])->name('dashboard');

// 認証が必要なルート
Route::middleware('auth')->group(function () {
    // プロフィール関連
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Google SSO
Route::get('/auth/google', [GoogleLoginController::class, 'redirectToGoogle'])
    ->name('login.google');

Route::get('/auth/google/callback', [GoogleLoginController::class, 'handleGoogleCallback'])
    ->name('login.google.callback');

// logout
Route::post('/logout', function (Request $request) {
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    // ログアウト後はトップページへ (home)
    return redirect()->route('home');
})->name('logout');
