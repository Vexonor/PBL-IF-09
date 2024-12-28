<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OTPModel extends Model
{
    protected $table = "User_Otp";
    protected $primaryKey = "id";
    protected $fillable = [
        "ID_User",
        "Kode_Otp",
        "expired_at"
    ];

    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User', 'ID_User');
    }
}
