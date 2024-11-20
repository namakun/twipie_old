<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ImageSetting extends Model
{
    use HasFactory;

    public function botSetting()
    {
        return $this->belongsTo(BotSetting::class);
    }
}
