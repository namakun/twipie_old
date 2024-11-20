<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VideoSetting extends Model
{
    use HasFactory;

    public function botSetting()
    {
        return $this->belongsTo(BotSetting::class);
    }
}
