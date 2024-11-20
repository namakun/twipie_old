<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BotSetting extends Model
{
    use HasFactory;

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function videoSetting()
    {
        return $this->hasOne(VideoSetting::class);
    }

    public function imageSetting()
    {
        return $this->hasOne(ImageSetting::class);
    }

    public function store(Request $request)
    {
        $botSetting = new BotSetting();
        $botSetting->user_id = auth()->id();
        $botSetting->type = $request->type;
        $botSetting->general_settings = $request->general_settings;
        $botSetting->save();

        return redirect()->route('bot-settings.index')->with('success', '設定を作成しました');
    }

}
