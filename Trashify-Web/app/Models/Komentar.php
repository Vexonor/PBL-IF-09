<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Komentar extends Model
{
    protected $table = "Komentar";
    protected $primaryKey = "ID_Komentar";
    protected $fillable = [
        "ID_Edukasi",
        "ID_User",
        "Isi_Komentar",
    ];
    public function EdukasiTable()
    {
        return $this->belongsTo(KontenModel::class, 'ID_Edukasi');
    }
    public function UserTable()
    {
        return $this->belongsTo(User::class, 'ID_User');
    }
}
