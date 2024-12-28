<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Warga extends Model
{
    use HasFactory;
    protected $table = "Warga";
    protected $primaryKey = "ID_Warga";
    protected $fillable = [
        "ID_User",
    ];

    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User');
    }
}
