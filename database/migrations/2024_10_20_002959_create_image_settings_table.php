<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('image_settings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('setting_id')->constrained('settings')->onDelete('cascade'); // Settingと関連付ける
            $table->timestamp('post_time'); // 投稿予定時間
            $table->integer('tweet_count_per_day')->default(0); // 0〜5 のツイート数
            $table->string('post_message');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('image_settings');
    }
};
